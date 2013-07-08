//
//  indeed_TokenInfo.m
//  Mobile OTP for Indeed-ID
//
//  Created by Константин Полтарацкий on 02.07.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "indeed_TokenInfo.h"

@implementation indeed_TokenInfo

@synthesize ID = _ID;
@synthesize name = _name;
@synthesize pin = _pin;
@synthesize secret = _secret;

//Сет и гет для свойств
- (NSInteger)ID
{
    return _ID;
}

- (void)setID:(NSInteger)ID
{
    _ID = ID;
}
/*
- (NSString *)name
{
    return _name;
}

- (void)setName:(NSString *)name
{
    _name = name;
}

- (NSString *)pin
{
    return _pin;
}

- (void)setPin:(NSString *)pin
{
    _pin = pin;
}

- (NSString *)secret
{
    return _secret;
}

- (void)setSecret:(NSString *)secret
{
    _secret = secret;
}
*/
//Операции с базой данных

+ (NSMutableArray *)GetTokenList
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    const char *dbpath = [[indeed_PublicPropertiesAndMethods.dburl path] UTF8String];
    sqlite3 *db;
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        const char *query = "SELECT \"ID\", \"Name\", \"PIN\", \"Secret\" FROM \"Token\"";
        //char *errmsg;
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, query, -1, &statement, NULL) == SQLITE_OK)
        {
            //Отправка запроса
            NSLog(@"Tokens selected successfully");
            //Код выбора будет здесь
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //Добавление в NSDictionary
                indeed_TokenInfo *ti = [[indeed_TokenInfo alloc] init];
                //char * secr = sqlite3_column_text(statement, 1);
                ti.ID = sqlite3_column_int(statement, 0);
                ti.name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                ti.pin = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                ti.secret = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                [arr addObject:ti];
            }
        
        }
        else {
            NSLog(@"Can't select list of tokens");
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    else {
        NSLog(@"Error opening db for read");
    }

    
    return arr;
}

- (void)GetTokenInfo:(NSInteger)tokenID
{
    const char *dbpath = [[indeed_PublicPropertiesAndMethods.dburl path] UTF8String];
    sqlite3 *db;
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        NSString *query_obj = [NSString stringWithFormat:@"SELECT \"ID\", \"Name\", \"PIN\", \"Secret\" FROM \"Token\" WHERE \"ID\" = %d", tokenID];
        const char *query = [query_obj UTF8String];
        //char *errmsg;
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, query, -1, &statement, NULL) == SQLITE_OK)
        {
            //Отправка запроса
            NSLog(@"Token selected successfully");
            //Код выбора будет здесь
            
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                _ID = sqlite3_column_int(statement, 0);
                _name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                _pin = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                _secret = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
            
        }
        else {
            NSLog(@"Can't select token info");
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    else {
        NSLog(@"Error opening db for read id");
    }
}

- (BOOL)InsertTokenInfo
{
    const char *dbpath = [[indeed_PublicPropertiesAndMethods.dburl path] UTF8String];
    sqlite3 *db;
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        NSString *query_obj = [NSString stringWithFormat:@"INSERT INTO \"Token\" (\"Name\", \"PIN\", \"Secret\") VALUES ('%@', '%@', '%@');", [self name], _pin, _secret];
        const char *query = [query_obj UTF8String];
        char *errmsg;
        if (sqlite3_exec(db, query, NULL, NULL, &errmsg) == SQLITE_OK)
        {
            return YES;
            
        }
        else {
            NSLog(@"Can't insert token. Error: %@", [NSString stringWithUTF8String:errmsg]);
            return NO;
        }
        sqlite3_close(db);
    }
    else {
        NSLog(@"Error opening db for inserting");
        return NO;
    }

}

- (BOOL)UpdateTokenInfo
{
    const char *dbpath = [[indeed_PublicPropertiesAndMethods.dburl path] UTF8String];
    sqlite3 *db;
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        NSString *query_obj = [NSString stringWithFormat:@"UPDATE \"Token\" SET \"Name\" = '%@', \"PIN\" = '%@', \"Secret\" = '%@' WHERE \"ID\" = %d;", _name, _pin, _secret, _ID];
        const char *query = [query_obj UTF8String];
        char *errmsg;
        if (sqlite3_exec(db, query, NULL, NULL, &errmsg) == SQLITE_OK)
        {
            return YES;
            
        }
        else {
            NSLog(@"Can't update token. Error: %@", [NSString stringWithUTF8String:errmsg]);
            return NO;
        }
        sqlite3_close(db);
    }
    else {
        NSLog(@"Error opening db for inserting");
        return NO;
    }
}

- (BOOL)DeleteTokenInfo
{
    const char *dbpath = [[indeed_PublicPropertiesAndMethods.dburl path] UTF8String];
    sqlite3 *db;
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        NSString *query_obj = [NSString stringWithFormat:@"DELETE FROM \"Token\" WHERE \"ID\" = %d;", _ID];
        const char *query = [query_obj UTF8String];
        char *errmsg;
        if (sqlite3_exec(db, query, NULL, NULL, &errmsg) == SQLITE_OK)
        {
            return YES;
            
        }
        else {
            NSLog(@"Can't delete token. Error: %@", [NSString stringWithUTF8String:errmsg]);
            return NO;
        }
        sqlite3_close(db);
    }
    else {
        NSLog(@"Error opening db for deleting");
        return NO;
    }
}

@end
