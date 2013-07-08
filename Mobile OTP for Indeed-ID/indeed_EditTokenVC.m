//
//  indeed_EditTokenVC.m
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 03.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "indeed_EditTokenVC.h"

@interface indeed_EditTokenVC ()

@end

@implementation indeed_EditTokenVC
@synthesize TokenNameTextField;
@synthesize SecretInitTextField;
@synthesize PinTextField;
@synthesize cancelButton;
@synthesize doneButton;
@synthesize GenerateButton;
@synthesize TokenID = _TokenID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        gr.delegate = self;
        [self.view addGestureRecognizer:gr];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.TokenNameTextField.delegate = self;
    self.SecretInitTextField.delegate = self;
    self.PinTextField.delegate = self;
}

- (void)viewDidUnload
{
    [self setTokenNameTextField:nil];
    [self setSecretInitTextField:nil];
    [self setPinTextField:nil];
    [self setCancelButton:nil];
    [self setDoneButton:nil];
    [self setGenerateButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated
{
    indeed_TokenInfo *ti = [[indeed_TokenInfo alloc] init];
    ti.ID = [self TokenID];
    [ti GetTokenInfo:[self TokenID]];
    self.TokenNameTextField.text = [ti name];
    self.SecretInitTextField.text = [ti secret];
    self.PinTextField.text = [ti pin];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneEdit:(id)sender {
    [self.PinTextField resignFirstResponder];
    [self.SecretInitTextField resignFirstResponder];
    [self.TokenNameTextField resignFirstResponder];
}

- (IBAction)doneButtonPressed:(id)sender {
    if ([self checkIfInputedDataIsCorrect] == YES)
    {
        indeed_TokenInfo *ti = [[indeed_TokenInfo alloc] init];
        ti.ID = [self TokenID];
        ti.name = [self.TokenNameTextField text];
        ti.secret = [self.SecretInitTextField text];
        ti.pin = [self.PinTextField text];
        if ([ti UpdateTokenInfo] == YES)
        {
            NSLog(@"Данные токена отредактированы успешно");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            NSLog(@"Произошла ошибка во время редактирования");
        }
    }
}

- (IBAction)cancelButtonPressed:(id)sender {
    //Возвращаемся назад
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)generate:(id)sender {
    self.SecretInitTextField.text = [self GenerateSecretInit];
}

- (IBAction)tapped:(UITapGestureRecognizer *)sender
{
    [self.PinTextField resignFirstResponder];
    [self.SecretInitTextField resignFirstResponder];
    [self.TokenNameTextField resignFirstResponder];
    
    CGPoint p = [sender locationOfTouch:0 inView:self.view];
    
    CGPoint canc = cancelButton.frame.origin;
    CGPoint done = doneButton.frame.origin;
    CGPoint gen = GenerateButton.frame.origin;
    int cancX = canc.x + cancelButton.frame.size.width;
    int cancY = canc.y + cancelButton.frame.size.height;
    int doneX = done.x + doneButton.frame.size.width;
    int doneY = done.y + doneButton.frame.size.height;
    int gx = gen.x + GenerateButton.frame.size.width;
    int gy = gen.y + GenerateButton.frame.size.height;
    
    if (p.x > canc.x && p.x < cancX && p.y > canc.y && p.y < cancY)
    {
        [self cancelButtonPressed:[self cancelButton]];
    }
    else if (p.x > done.x && p.x < doneX && p.y > done.y && p.y < doneY)
    {
        [self doneButtonPressed:[self doneButton]];
    }
    else if (p.x > gen.x && p.x < gx && p.y > gen.y && p.y < gy)
    {
        [self generate:[self GenerateButton]];
    }
}

- (BOOL) checkIfInputedDataIsCorrect
{
    if ([self.SecretInitTextField.text length] == 16 && [self.PinTextField.text length] == 4)
        return YES;
    else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Секретное слово должно быть длиной 16 символов, PIN-код длиной 4 цифры." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
        return NO;
    }
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

@end
