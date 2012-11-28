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

@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    Driver* tDriver = [Driver findFirst];
    if( !tDriver ) {
        [self performSegueWithIdentifier:@"CreateSession" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
}

@end
