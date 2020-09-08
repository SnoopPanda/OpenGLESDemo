//
//  AppDelegate.m
//  OpenGLESDemo
//
//  Created by 王杰 on 2020/8/27.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "AppDelegate.h"
#import "SPViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
      
    UIViewController *vc = [[SPViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
      
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
