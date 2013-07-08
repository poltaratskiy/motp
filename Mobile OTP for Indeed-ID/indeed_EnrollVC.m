//
//  indeed_EnrollVC.m
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 03.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "indeed_EnrollVC.h"

@interface indeed_EnrollVC ()
@property BOOL started;
@end

@implementation indeed_EnrollVC
@synthesize progressBar;
@synthesize TokenNameLabel;
@synthesize PinTextField;
@synthesize OTPTextField;
@synthesize TokenID = _TokenID;
@synthesize generateButton;
@synthesize backView;
@synthesize pin = _pin;
@synthesize secret = _secret;
@synthesize started = _started;

- (NSInteger) TokenID
{
    return _TokenID;
}

- (void) setTokenID:(NSInteger)TokenID
{
    _TokenID = TokenID;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.PinTextField.delegate = self;
        
        
        
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
    self.progressBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    indeed_TokenInfo *ti = [[indeed_TokenInfo alloc] init];
    [ti GetTokenInfo:[self TokenID]];
    self.TokenNameLabel.text = [ti name];
    self.pin = [ti pin];
    self.secret = [ti secret];
    self.navigationItem.title = @"Получение пароля";
    self.PinTextField.text = @"";
    [self.progressBar setProgress:0.0];
    self.started = NO;
}

- (void)viewDidUnload
{
    [self setTokenNameLabel:nil];
    [self setPinTextField:nil];
    [self setOTPTextField:nil];
    [self setProgressBar:nil];
    [self setGenerateButton:nil];
    [self setBackView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)tapped:(UITapGestureRecognizer *)sender {
    [self.PinTextField resignFirstResponder];
    CGPoint p = [sender locationOfTouch:0 inView:[self backView]];
    CGPoint b = self.generateButton.frame.origin;
    int bx = b.x + self.generateButton.frame.size.width;
    int by = b.y + self.generateButton.frame.size.height;
    
    if (p.x > b.x && p.x < bx && p.y > b.y && p.y < by)
    {
        //Если жест над кнопкой
        [self GenerateButtonPress:[self generateButton]];
    }
    else if (p.x > 7 && p.x < 123 && p.y > 380 && p.y < 430)
    {
        //Кнопка изменить токен
        [self EditToken:[self.toolbarItems objectAtIndex:1]];
    }
    else if (p.x > 130 && p.x < 246 && p.y > 380 && p.y < 430)
    {
        //Кнопка удалить токен
        [self DeleteToken:[self.toolbarItems objectAtIndex:0]];
    }

    
}
- (IBAction)GenerateButtonPress:(id)sender {
    if ([self checkPin] == YES)
    {
        //Generate random password here
        NSString * hexStr = [NSString stringWithFormat:@"%@",
                             [NSData dataWithBytes:[[self secret] cStringUsingEncoding:NSUTF8StringEncoding] 
                                            length:strlen([[self secret] cStringUsingEncoding:NSUTF8StringEncoding])]];
        
        for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">", @" ", nil]) 
            hexStr = [hexStr stringByReplacingOccurrencesOfString:toRemove withString:@""];
        
        NSString *hexStr2 = [NSString stringWithFormat:@"%x", [self secret]];
        
        NSLog(@"Dec secret: %@", [self secret]);
        NSLog(@"Hex secret: %@", hexStr2);
        
        long tm = time(0) / 10;
        NSLog(@"Оригинальное время: %ld, уменьшенное: %ld", time(0), tm);
        
        NSString *input = [NSString stringWithFormat:@"%ld%@%@", tm, [self secret], [self pin]];
        NSLog(@"Входная строка: %@", input);
        
        NSString *output = [self md5:input];
        NSString *otp = [output substringToIndex:6];
        NSLog(@"Одноразовый пароль: %@", otp);
        
        self.OTPTextField.text = otp;
        self.started = NO;
        NSLog(@"Stopped");
        
        
        //Прогрессбар
        //[NSThread detachNewThreadSelector:@selector(startTheBackgroundMove) toTarget:self withObject:nil];
        
        
        /*
        //Прогрессбар
        void (^progressBlock)(void);
        progressBlock = ^{
            [self.progressBar setProgress:0.0];
            
            //NSLog(@"Time: %ld", time(0));
            
            long finish = time(0) + 5;
            long start = time(0);
            NSLog(@"time: %ld, finish: %ld", time(0), finish);
            self.started = YES;
            NSLog(@"Started");
            while (time(0) <= finish || self.started == YES) {
                //if (i++ >= processAmount) { // processAmount is something like 1000000
                //    running = NO;
                //    continue;
                //}
                //continue;
                
                // Update progress bar
           //     double progr = (time(0) - start) / (double)5.0;
                //NSLog(@"progr: %f", progr); // Logs values between 0.0 and 1.0
                
                //NOTE: It is important to let all UI updates occur on the main thread,
                //so we put the following UI updates on the main queue.
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.progressBar setProgress:(float)progr];
                    //[self.progressBar setNeedsDisplay:YES];
                });
                
                if (time(0) == finish)
                {
                    [self.progressBar setProgress:1.0];
                    self.OTPTextField.text = @"";
                    self.started = NO;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                        [self.progressBar setProgress:(float)progr];
                    });
                    
                
                // Do some more hard work here...
            }
            
        };
        dispatch_queue_t queue = dispatch_get_global_queue(0,0);
        dispatch_async(queue,progressBlock);
        dispatch_release(queue);
        
        */
    }
}
         
- (void) startTheBackgroundMove
{
    [NSThread sleepForTimeInterval:0];
    [self performSelectorOnMainThread:@selector(makeMyBarMoving) withObject:nil waitUntilDone:NO];
    [NSThread exit];
}

- (void) makeMyBarMoving
{
    long finish = time(0) + 5;
    double progre = 1.0;
    while (time(0) < finish/* || self.started == YES*/) {
        progre = (finish - time(0)) / (double)5.0;
        [self.progressBar setProgress:(float)progre];
        if (time(0) == finish)
        {
            [self.progressBar setProgress:1.0];
            self.OTPTextField.text = @"";
            //self.started = NO;
        }
    }
}

- (BOOL)checkPin
{
    if (![self.pin isEqualToString:[self.PinTextField text]])
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"PIN" message:@"Неверный PIN-код" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
        return  NO;
    }
    else 
        return YES;
}


- (IBAction)DeleteToken:(id)sender {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Внимание" message:@"Вы действительно хотите удалить этот токен?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
    [av show];
}

- (IBAction)EditToken:(id)sender {
    if ([self checkPin] == YES)
    {
        indeed_EditTokenVC *dvc = [[indeed_EditTokenVC alloc] initWithNibName:@"EditTokeniPhoneView" bundle:nil];
        //set properties...
        dvc.TokenID = [self TokenID];
        dvc.navigationController.title = @"Редактирование";
        dvc.navigationItem.title = @"Редактирование";
        dvc.navigationItem.backBarButtonItem.title = [self.navigationItem title];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Нажата кнопка %d", buttonIndex);
    //Кнопка 1 - да, 0 - нет
    if (buttonIndex == 1)
    {
        indeed_TokenInfo *dti = [[indeed_TokenInfo alloc] init];
        dti.ID = [self TokenID];
        if ([dti DeleteTokenInfo] == YES)
        {
            NSLog(@"Токен удалён");
            indeed_MainViewController * mvc = (indeed_MainViewController*)[self.navigationController parentViewController];
            [mvc.tableVC reloadData];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSLog(@"Ошибка при удалении токена");
        }
    }
}

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    NSLog(@"Хеш функция: %@", output);
    return  output;
    
}


@end
