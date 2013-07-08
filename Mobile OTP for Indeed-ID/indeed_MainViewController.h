//
//  indeed_MainViewController.h
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 02.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indeed_TokenInfo.h"
#import "indeed_MainTableView.h"
#import "indeed_AddTokenVC.h"
#import "indeed_PublicPropertiesAndMethods.h"
#import "indeed_EnrollVC.h"

@interface indeed_MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet indeed_MainTableView *tableVC;
- (IBAction)AddPressed:(id)sender;

- (void)refreshData;

@end
