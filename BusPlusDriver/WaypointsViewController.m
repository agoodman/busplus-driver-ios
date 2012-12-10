//
//  WaypointsViewController.m
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "WaypointsViewController.h"


@interface WaypointsViewController ()

@end

@implementation WaypointsViewController

@synthesize mapView = _mapView, onDutyLabel = _onDutyLabel, locationManager = _locationManager;

- (void)createVehicle
{
    Driver* tDriver = [Driver findFirst];
    
    Vehicle* tVehicle = [Vehicle object];
    tVehicle.latitude = [NSNumber numberWithDouble:self.locationManager.location.coordinate.latitude];
    tVehicle.longitude = [NSNumber numberWithDouble:self.locationManager.location.coordinate.longitude];
    tVehicle.driverId = tDriver.driverId;
    tVehicle.seatsAvailable = [NSNumber numberWithInt:[[NSUserDefaults standardUserDefaults] integerForKey:@"Seats"]];
    tVehicle.token = [[NSUserDefaults standardUserDefaults] valueForKey:@"Token"];
    [[RKObjectManager sharedManager] postObject:tVehicle delegate:self];
}

- (void)registerVehicle
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge];
}

- (void)resolveLocation:(NSNotification*)aNotif
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PushNotificationEnabled" object:nil];
    
    NSString* tToken = (NSString*)aNotif.object;
    [[NSUserDefaults standardUserDefaults] setValue:tToken forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)settingsChanged
{
    BOOL tOnDuty = [[NSUserDefaults standardUserDefaults] boolForKey:@"OnDuty"];
    int tSeats = [[NSUserDefaults standardUserDefaults] boolForKey:@"Seats"];
    async_main(^{
        self.onDutyLabel.title = tOnDuty ? @"YES" : @"NO";
    });
    
    BOOL tDiff = NO;
    Vehicle* tVehicle = [Vehicle findFirst];
    if( tVehicle.onDuty.boolValue!=tOnDuty ) {
        tDiff = YES;
        tVehicle.onDuty = [NSNumber numberWithBool:tOnDuty];
    }
    if( tVehicle.seatsAvailable.intValue!=tSeats ) {
        tDiff = YES;
        tVehicle.seatsAvailable = [NSNumber numberWithInt:tSeats];
    }
    if( tDiff ) {
        [[RKObjectManager sharedManager] putObject:tVehicle delegate:self];
    }
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsChanged) name:@"SettingsChanged" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    Driver* tDriver = [Driver findFirst];
    if( tDriver ) {
        Vehicle* tVehicle = [Vehicle findFirst];
        if( tVehicle ) {
            self.mapView.showsUserLocation = YES;
        }else{
            [self registerVehicle];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resolveLocation:) name:@"PushNotificationEnabled" object:nil];
        }
    }else{
        [self performSegueWithIdentifier:@"CreateSession" sender:self];
    }
    
    [self settingsChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    async_main(^{
        [mapView setRegion:MKCoordinateRegionMake(self.locationManager.location.coordinate, MKCoordinateSpanMake(0.1, 0.1)) animated:YES];
    });
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (CLLocation* location in locations) {
        if( location.horizontalAccuracy<100 ) {
            [manager stopUpdatingLocation];
            manager.delegate = nil;
            self.mapView.showsUserLocation = YES;
            [self createVehicle];
            break;
        }
    }
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Vehicle Web Error: %@\nrequest: %@",objectLoader.response.bodyAsString,objectLoader.response.request.HTTPBodyString);
    async_main(^{
        Alert(@"Vehicle Error", @"unable to save vehicle");
    })
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    async_main(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"VehicleChanged" object:nil];
    });
}

@end
