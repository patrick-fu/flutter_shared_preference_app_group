#import "SharedPreferenceAppGroupPlugin.h"
#import <objc/message.h>

@interface SharedPreferenceAppGroupPlugin ()

@property (nonatomic, copy) NSString *appGroup;

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@property (nonatomic, copy) NSDictionary<NSString *, NSValue *> *seletors;

@end

@implementation SharedPreferenceAppGroupPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"shared_preference_app_group" binaryMessenger:[registrar messenger]];
    SharedPreferenceAppGroupPlugin* instance = [[SharedPreferenceAppGroupPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

    NSValue *value = [self.seletors objectForKey:call.method];
    SEL selector;
    if (!value) {
        selector = NSSelectorFromString([NSString stringWithFormat:@"%@:result:", call.method]);
        [self.seletors setValue:[NSValue valueWithPointer:selector] forKey:call.method];
    } else {
        selector = value.pointerValue;
    }

    // Handle unrecognized method
    if (![self respondsToSelector:selector]) {
        NSLog(@"[handleMethodCall] Unrecognized selector: %@", call.method);
        result(FlutterMethodNotImplemented);
        return;
    }

    // Invoke method
    ((void (*)(id, SEL, FlutterMethodCall *, FlutterResult))objc_msgSend)(self, selector, call, result);
}

#pragma mark - Handle method call

- (void)setAppGroup:(FlutterMethodCall *)call result:(FlutterResult)result {
    self.appGroup = call.arguments[@"appGroup"];
    self.userDefaults = [[NSUserDefaults alloc] initWithSuiteName:_appGroup];
    result(nil);
}

- (void)setBool:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self checkAppGroup:result];

    NSString *key = call.arguments[@"key"];
    NSNumber *value = call.arguments[@"value"];
    [self.userDefaults setBool:value.boolValue forKey:key];
    result(nil);
}

- (void)setInt:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self checkAppGroup:result];

    NSString *key = call.arguments[@"key"];
    NSNumber *value = call.arguments[@"value"];
    // int type in Dart can come to native side in a variety of forms
    // It is best to store it as is and send it back when needed.
    // Platform channel will handle the conversion.
    [self.userDefaults setValue:value forKey:key];
    result(nil);
}

- (void)setDouble:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self checkAppGroup:result];

    NSString *key = call.arguments[@"key"];
    NSNumber *value = call.arguments[@"value"];
    [self.userDefaults setDouble:value.doubleValue forKey:key];
    result(nil);
}

- (void)setString:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self checkAppGroup:result];

    NSString *key = call.arguments[@"key"];
    NSString *value = call.arguments[@"value"];
    [self.userDefaults setValue:value forKey:key];
    result(nil);
}

- (void)get:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self checkAppGroup:result];

    NSString *key = call.arguments[@"key"];
    id value = [self.userDefaults valueForKey:key];
    result(value);
}

- (void)getAll:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self checkAppGroup:result];

    NSDictionary *allPreferences = [self.userDefaults persistentDomainForName:self.appGroup];
    if (allPreferences && allPreferences.count > 0) {
        result(allPreferences);
    } else {
        result(@{});
    }
}

- (void)remove:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self checkAppGroup:result];

    NSString *key = call.arguments[@"key"];
    [self.userDefaults removeObjectForKey:key];
    result(nil);
}

- (void)removeAll:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self checkAppGroup:result];

    NSDictionary *allPreferences = [self.userDefaults persistentDomainForName:self.appGroup];
    for (NSString *key in allPreferences) {
        [self.userDefaults removeObjectForKey:key];
    }
    result(nil);
}

#pragma mark - Private

- (void)checkAppGroup:(FlutterResult)result {
    if (!self.appGroup || !self.userDefaults) {
        result([FlutterError errorWithCode:@"APP_GROUP_HAS_NOT_BEEN_SET" message:@"You need to call `setAppGroup` before using" details:nil]);
    }
}


@end
