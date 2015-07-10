//
//  AppDelegate.m
//  oye2
//
//  Created by Lee on 15-6-1.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "WelcomeViewController.h"

@interface AppDelegate () {
    //BOOL isFirstLogin;//首次登录
    int (^myblock)(int);
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//iPhone4[width = 320.00;height = 480.00]
    self.window.backgroundColor = [UIColor blackColor];
    /*
    __block int b = 3;
    
    myblock = ^(int i){
        
        return b =  b + 3 * i;
    };
    
    struct PEOPLE{
        int sex;
        int age;
        char *_name;
        char _id;
    } people;
    
    int size_people = sizeof(struct PEOPLE);
    int offset_age = offsetof(struct PEOPLE, age);
    int offset_name = offsetof(struct PEOPLE, _name);
    
    NSLog(@"PEOPLE sizeof %d", size_people);
    NSLog(@"offset_age %d", offset_age);
     NSLog(@"offset_name %d", offset_name);
    
    NSLog(@"size of char %lu", sizeof(people._id));
    
    people._name = "lee";
    
    printf("%s\n", people._name);
    
    
    NSLog(@"myblock return: %d  and b= %d", myblock(1), b);
    */
    [self start];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)start
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self setMainView_iPad];
    } else {
        [self setMainView_iPhone];
    }
}

- (void)setMainView_iPhone
{
    
    NSString *firstLogin = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"firstLogin"]];
    if (![firstLogin isEqualToString:@"no"]) {
        WelcomeViewController *welcomeVc = [[WelcomeViewController alloc] init];
        [self.window setRootViewController:welcomeVc];
    } else {
        self.mainVc = [[MainViewController alloc] init];
        [self.window setRootViewController:self.mainVc];
    }
}

- (void)setMainView_iPad
{
    
}

@end
