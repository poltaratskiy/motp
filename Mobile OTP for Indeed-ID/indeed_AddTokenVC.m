//
//  indeed_AddTokenVC.m
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 03.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "indeed_AddTokenVC.h"

@interface indeed_AddTokenVC ()

@end

@implementation indeed_AddTokenVC
@synthesize doneButton;
@synthesize genButton;
@synthesize SecretInitField;
@synthesize PinTextField;
@synthesize tokenNameTextField;
@synthesize Token = _Token;

- (indeed_TokenInfo *)Token
{
    if (_Token == nil)
        return [[indeed_TokenInfo alloc] init];
    else 
        return _Token;
}

- (void)setToken:(indeed_TokenInfo *)Token
{
    _Token = Token;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tokenNameTextField.delegate = self;
    self.SecretInitField.delegate = self;
    self.PinTextField.delegate = self;
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:gr];
}

- (void)viewDidUnload
{
    [self setSecretInitField:nil];
    [self setPinTextField:nil];
    [self setTokenNameTextField:nil];
    [self setDoneButton:nil];
    [self setGenButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)GenerateButtonPress:(UIButton *)sender {
    self.SecretInitField.text = [self GenerateSecretInit];
}

- (IBAction)SecretInitReturnPressed:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)PinReturnPressed:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (IBAction)NameReturnPressed:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (IBAction)DoneButtonPressed:(id)sender {
    indeed_TokenInfo *ti = [[indeed_TokenInfo alloc] init];
    ti.name = [self.tokenNameTextField text];
    ti.pin = [self.PinTextField text];
    ti.secret = [self.SecretInitField text];
    
    if ([ti.secret length] != 16 || [ti.pin length] != 4)
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Секретное слово должно быть длиной 16 символов, PIN-код длиной 4 цифры." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }
    else {
        if ([ti InsertTokenInfo] == YES)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Токен не добавлен!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [av show];
            
        }
    }
    
}

- (IBAction)CancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)BackgroundTap:(id)sender {
    [self.PinTextField resignFirstResponder];
    [self.SecretInitField resignFirstResponder];
    [self.tokenNameTextField resignFirstResponder];
}



- (NSString *) GenerateSecretInit
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:16];
        
    for (int i=0; i<16; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
}

- (IBAction)tapped:(UITapGestureRecognizer *)sender
{
    [self.tokenNameTextField resignFirstResponder];
    [self.PinTextField resignFirstResponder];
    [self.SecretInitField resignFirstResponder];
    
    CGPoint p = [sender locationOfTouch:0 inView:self.view];
    
    CGPoint done = self.doneButton.frame.origin;
    CGPoint gen = self.genButton.frame.origin;
    
    int dx = done.x + self.doneButton.frame.size.width;
    int dy = done.y + self.doneButton.frame.size.height;
    
    int gx = gen.x + self.genButton.frame.size.width;
    int gy = gen.y + self.genButton.frame.size.height;
    
    if (p.x > 5 && p.x < 80 && p.y > 5 && p.y < 33)
    {
        id a;
        [self CancelButtonPressed:a];
    }
    else if (p.x > done.x && p.x < dx && p.y > done.y && p.y < dy)
    {
        [self DoneButtonPressed:[self doneButton]];
    }
    else if (p.x > gen.x && p.x < gx && p.y > gen.y && p.y < gy)
    {
        [self GenerateButtonPress:[self genButton]];
    }
}

@end
