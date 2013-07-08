//
//  indeed_PublicPropertiesAndMethods.h
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 02.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"

@interface indeed_PublicPropertiesAndMethods : NSObject

+ (NSURL*)dburl;

- (BOOL)CreateDB;

@end
