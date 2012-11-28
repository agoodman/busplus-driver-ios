//
//  WaypointsViewController.h
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface WaypointsViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,RKObjectLoaderDelegate>

@property (strong) IBOutlet MKMapView* mapView;
@property (strong) IBOutlet UIBarButtonItem* onDutyLabel;
@property (strong) CLLocationManager* locationManager;

@end
