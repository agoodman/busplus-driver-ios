//
//  SessionStartViewController.m
//  BusPlusDriver
//
//  Created by Aubrey Goodman on 11/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "SessionStartViewController.h"
#import "SessionAuthViewController.h"


@interface SessionStartViewController ()

@end

@implementation SessionStartViewController

@synthesize label = _label, textField = _textField, nextButton = _nextButton;

- (IBAction)nextButtonPressed:(id)sender
{
    [self.textField resignFirstResponder];
    [self performSegueWithIdentifier:@"CreateSession" sender:self];
}

#pragma mark - View life cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SessionAuthViewController* tAuth = (SessionAuthViewController*)segue.destinationViewController;
    tAuth.email = self.textField.text;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self nextButtonPressed:self.nextButton];
    return YES;
}


@end
