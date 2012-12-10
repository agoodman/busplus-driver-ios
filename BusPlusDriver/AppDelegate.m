//
//  AppDelegate.m
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (void)handleBidRequest:(Candidate*)aCandidate
{
    // TODO: compute number of seconds the given passenger would add to the waypoint path time
    // for now, return 1200 (20mins)
    aCandidate.bid = [NSNumber numberWithDouble:1200.0];
    [[RKObjectManager sharedManager] putObject:aCandidate delegate:self];
}

#pragma mark - App life cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // set up RestKit
    RKObjectManager* tMgr = [RKObjectManager managerWithBaseURLString:@"http://buspl.us/api"];
    tMgr.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"BusPlus.sqlite3"];
    
    [Passenger initObjectLoader:tMgr];
    [Vehicle initObjectLoader:tMgr];
    [Candidate initObjectLoader:tMgr];
    [Driver initObjectLoader:tMgr];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Push notification

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    async_main(^{
        if( [[error.userInfo description] rangeOfString:@"simulator"].location!=NSNotFound ) {
            NSLog(@"simulating push notification");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNotificationEnabled" object:@"abc123"];
        }else{
            NSLog(@"push notification error: %@",error.userInfo);
            Alert(@"Push Notification Required", @"An error was encountered");
        }
    });
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    async_main(^{
        NSString* tRaw = [deviceToken description];
        NSString* tToken = [[[tRaw stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNotificationEnabled" object:tToken];
    });
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"remote notification: %@",userInfo);
    NSNumber* tCandidateId = [userInfo valueForKey:@"candidate_id"];
    if( tCandidateId ) {
        Candidate* tCandidate = [Candidate object];
        tCandidate.candidateId = tCandidateId;
        [[RKObjectManager sharedManager] getObject:tCandidate delegate:self];
    }
    
    NSNumber* tPassengerId = [userInfo valueForKey:@"passenger_id"];
    if( tPassengerId ) {
        Passenger* tPassenger = [Passenger object];
        tPassenger.passengerId = tPassengerId;
        [[RKObjectManager sharedManager] getObject:tPassenger delegate:self];
    }
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Candidate Web Error: %@",objectLoader.response.bodyAsString);
    async_main(^{
        Alert(@"Error processing bid request", [error localizedDescription]);
    });
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    if( [object isKindOfClass:[Candidate class]] ) {
        Candidate* tCandidate = (Candidate*)object;
        if( tCandidate.bid.intValue!=0 ) {
            // bid successfully submitted; wait for assignment
        }else{
            NSLog(@"candidate received: %@",object);
            [self handleBidRequest:object];
        }
    }
    if( [object isKindOfClass:[Passenger class]] ) {
        async_main(^{
            Alert(@"Passenger Assigned", @"You have been assigned a new passenger");
        });
    }
}

@end
