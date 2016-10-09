//
//  AppDelegate.m
//  TestProject
//
//  Created by YC-JG-YXKF-PC35 on 16/9/23.
//  Copyright © 2016年 YC-JG-YXKF-PC35. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/message.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (id)testMethod:(NSString *)arg1 :(NSString *)arg2 :(NSString *)arg3 {
    NSString *s = [NSString stringWithFormat:@"%@,%@,%@",arg1,arg2,arg3];
    NSLog(@"s:%@",s);
    return s;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    objc_msgSend(self,@selector(testMethod:::),@"arg1",@"arg2",@"arg3");
    NSInvocation *invo = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(testMethod:::)]];
    [invo setTarget:self];
    [invo setSelector:@selector(testMethod:::)];
    NSString *a = @"arg1";
    NSString *b = @"arg2";
    NSString *c = @"arg3";
    [invo setArgument:&a atIndex:2];
    [invo setArgument:&b atIndex:3];
    [invo setArgument:&c atIndex:4];
    [invo invoke];
    id anObject;
    [invo getReturnValue:&anObject];
    NSLog(@"anObject:%@",anObject);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
