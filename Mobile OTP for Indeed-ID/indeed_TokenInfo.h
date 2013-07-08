//
//  indeed_TokenInfo.h
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 02.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indeed_PublicPropertiesAndMethods.h"

@interface indeed_TokenInfo : NSObject

@property NSInteger ID;
@property (retain) NSString *name;
@property (retain) NSString *pin;
@property (retain) NSString *secret;

+ (NSMutableArray *)GetTokenList;
- (void)GetTokenInfo:(NSInteger)tokenID;
- (BOOL)InsertTokenInfo;
- (BOOL)UpdateTokenInfo;
- (BOOL)DeleteTokenInfo;

@end
