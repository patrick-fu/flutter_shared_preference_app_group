#import "./include/shared_preference_app_group/SharedPreferenceAppGroupPlugin.h"
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
    NSDictionary *arguments = call.arguments;
    if (![arguments isKindOfClass:[NSDictionary class]]) {
        result([FlutterError errorWithCode:@"INVALID_ARGUMENTS" message:@"`setAppGroup` arguments must be a map" details:nil]);
        return;
    }

    id appGroup = arguments[@"appGroup"];
    if (![appGroup isKindOfClass:[NSString class]] || ((NSString *)appGroup).length == 0) {
        result([FlutterError errorWithCode:@"INVALID_APP_GROUP" message:@"`appGroup` must be a non-empty string" details:nil]);
        return;
    }

    self.appGroup = appGroup;
    self.userDefaults = [[NSUserDefaults alloc] initWithSuiteName:self.appGroup];
    if (!self.userDefaults) {
        result([FlutterError errorWithCode:@"APP_GROUP_COULD_NOT_BE_OPENED" message:@"Could not open the specified app group" details:nil]);
        return;
    }

    result(nil);
}

- (void)setBool:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSNumber *value = call.arguments[@"value"];
    [self.userDefaults setBool:value.boolValue forKey:key];
    result(nil);
}

- (void)setInt:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSNumber *value = call.arguments[@"value"];
    // int type in Dart can come to native side in a variety of forms
    // It is best to store it as is and send it back when needed.
    // Platform channel will handle the conversion.
    [self.userDefaults setValue:value forKey:key];
    result(nil);
}

- (void)setDouble:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSNumber *value = call.arguments[@"value"];
    [self.userDefaults setDouble:value.doubleValue forKey:key];
    result(nil);
}

- (void)setString:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSString *value = call.arguments[@"value"];
    [self.userDefaults setValue:value forKey:key];
    result(nil);
}

- (void)setStringArray:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSArray *value = call.arguments[@"value"];
    [self.userDefaults setValue:value forKey:key];
    result(nil);
}

- (void)get:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    id value = [self.userDefaults valueForKey:key];
    result(value);
}

- (void)getBool:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSNumber *value = [NSNumber numberWithBool:[self.userDefaults boolForKey:key]];
    result(value);
}

- (void)getInt:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSNumber *value = [NSNumber numberWithLong:[self.userDefaults integerForKey:key]];
    result(value);
}

- (void)getDouble:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSNumber *value = [NSNumber numberWithDouble:[self.userDefaults doubleForKey:key]];
    result(value);
}

- (void)getString:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSString *value = [self.userDefaults stringForKey:key];
    result(value);
}

- (void)getStringArray:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    NSArray<NSString *> *value = [self.userDefaults stringArrayForKey:key];
    result(value);
}

- (void)getAll:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSDictionary *allPreferences = [self.userDefaults persistentDomainForName:self.appGroup];
    if (allPreferences && allPreferences.count > 0) {
        result(allPreferences);
    } else {
        result(@{});
    }
}

- (void)remove:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSString *key = call.arguments[@"key"];
    [self.userDefaults removeObjectForKey:key];
    result(nil);
}

- (void)removeAll:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (![self checkAppGroup:result]) {
        return;
    }

    NSDictionary *allPreferences = [self.userDefaults persistentDomainForName:self.appGroup];
    for (NSString *key in allPreferences) {
        [self.userDefaults removeObjectForKey:key];
    }
    result(nil);
}

#pragma mark - Private

- (BOOL)checkAppGroup:(FlutterResult)result {
    if (!self.appGroup || !self.userDefaults) {
        result([FlutterError errorWithCode:@"APP_GROUP_HAS_NOT_BEEN_SET" message:@"You need to call `setAppGroup` before using" details:nil]);
        return NO;
    }

    return YES;
}


@end
