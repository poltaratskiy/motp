//
//  indeed_PublicPropertiesAndMethods.m
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 02.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "indeed_PublicPropertiesAndMethods.h"

@implementation indeed_PublicPropertiesAndMethods

+ (NSURL*)dburl
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"db.sqlite"];
    return url;
}

- (BOOL)CreateDB
{
    BOOL result = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:[indeed_PublicPropertiesAndMethods.dburl path]])
    {
        const char *dbpath = [[indeed_PublicPropertiesAndMethods.dburl path] UTF8String];
        sqlite3 *db;
        if (sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            const char *query = "CREATE TABLE \"Token\" (\"ID\" INTEGER PRIMARY KEY AUTOINCREMENT, \"Name\" TEXT, \"PIN\" TEXT, \"Secret\" TEXT)";
            char *errmsg;
            if (sqlite3_exec(db, query, NULL, NULL, &errmsg) == SQLITE_OK)
            {
                NSLog(@"Table created successfully");
                result = YES;
            }
            else {
                NSLog(@"Can't create table");
            }
            sqlite3_close(db);
        }
        else {
            NSLog(@"Error opening db to create");
        }
    }
    return result;
}

@end
