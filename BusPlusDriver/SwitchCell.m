//
//  SwitchCell.m
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

@synthesize onDuty = _onDuty;

- (IBAction)switchChanged:(id)sender
{
    BOOL tOnDuty = self.onDuty.on;
    [[NSUserDefaults standardUserDefaults] setBool:tOnDuty forKey:@"OnDuty"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"SettingsChanged" object:nil];
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    SwitchCell* tCell = [super initWithCoder:aDecoder];
//    [tCell.onDuty addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//    return tCell;
//}

@end
