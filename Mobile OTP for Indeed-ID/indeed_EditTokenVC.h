//
//  indeed_EditTokenVC.h
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 03.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indeed_TokenInfo.h"


@interface indeed_EditTokenVC : UIViewController<UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *TokenNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *SecretInitTextField;

@property (weak, nonatomic) IBOutlet UITextField *PinTextField;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *GenerateButton;

- (IBAction)doneEdit:(id)sender;

- (IBAction)doneButtonPressed:(id)sender;

- (IBAction)cancelButtonPressed:(id)sender;

- (IBAction)generate:(id)sender;

@property (nonatomic) NSInteger TokenID;

@end
