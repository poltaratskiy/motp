//
//  indeed_EnrollVC.h
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 03.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indeed_TokenInfo.h"
#import "indeed_MainViewController.h"
#import "indeed_EditTokenVC.h"
#import <CommonCrypto/CommonDigest.h>

@interface indeed_EnrollVC : UIViewController <UIGestureRecognizerDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) NSInteger TokenID;
@property (weak, nonatomic) IBOutlet UIButton *generateButton;

@property (weak, nonatomic) IBOutlet UIView *backView;

- (IBAction)tapped:(UITapGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet UILabel *TokenNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *PinTextField;

@property (weak, nonatomic) IBOutlet UILabel *OTPTextField;

- (IBAction)GenerateButtonPress:(id)sender;

@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@property (nonatomic, strong) NSString *pin;
@property (nonatomic, strong) NSString *secret;

- (IBAction)DeleteToken:(id)sender;
- (IBAction)EditToken:(id)sender;


@end
