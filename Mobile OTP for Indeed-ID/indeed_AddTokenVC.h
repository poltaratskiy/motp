//
//  indeed_AddTokenVC.h
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 03.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indeed_TokenInfo.h"

@interface indeed_AddTokenVC : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) indeed_TokenInfo *Token;

@property (weak, nonatomic) IBOutlet UITextField *SecretInitField;

@property (weak, nonatomic) IBOutlet UITextField *PinTextField;
@property (weak, nonatomic) IBOutlet UITextField *tokenNameTextField;

- (IBAction)GenerateButtonPress:(UIButton *)sender;

- (IBAction)SecretInitReturnPressed:(UITextField *)sender;

- (IBAction)PinReturnPressed:(UITextField *)sender;
- (IBAction)NameReturnPressed:(UITextField *)sender;

- (IBAction)DoneButtonPressed:(id)sender;

- (IBAction)CancelButtonPressed:(id)sender;

- (IBAction)BackgroundTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *genButton;


@end
