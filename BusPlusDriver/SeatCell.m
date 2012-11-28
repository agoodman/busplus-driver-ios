//
//  SeatCell.m
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "SeatCell.h"

@implementation SeatCell

@synthesize seatLabel = _seatLabel, stepper = _stepper;

- (IBAction)stepperChanged:(id)sender
{
    int tSeats = (int)self.stepper.value;
    [[NSUserDefaults standardUserDefaults] setInteger:tSeats forKey:@"Seats"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.seatLabel.text = [NSString stringWithFormat:@"%d",tSeats];
}

@end
