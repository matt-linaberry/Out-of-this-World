//
//  OWAddSpaceObjectViewController.h
//  Out of this World
//
//  Created by Matthew Linaberry on 10/19/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWAddSpaceObjectViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)addButtonPressed:(id)sender;

@end
