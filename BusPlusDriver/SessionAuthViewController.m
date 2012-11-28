//
//  SessionAuthViewController.m
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "SessionAuthViewController.h"


@interface SessionAuthViewController ()

@end

@implementation SessionAuthViewController

@synthesize email = _email, label = _label, textField = _textField, doneButton = _doneButton;

- (IBAction)doneButtonPressed:(id)sender
{
    [self.textField resignFirstResponder];
    
    [self registerDriver];
}

- (void)registerDriver
{
    Driver* tDriver = [Driver object];
    tDriver.email = self.email;
    tDriver.licenseNumber = self.textField.text;
    [[RKObjectManager sharedManager] postObject:tDriver delegate:self];
}

#pragma mark - View life cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.label.text = self.email;
    [self.textField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self doneButtonPressed:self.doneButton];
    return YES;
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    Alert(@"Driver Registration Error", error.localizedDescription);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
