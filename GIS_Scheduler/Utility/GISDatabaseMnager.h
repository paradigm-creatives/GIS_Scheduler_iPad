//
//  GISDatabaseMnager.h
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 14/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "GISAppDelegate.h"

@interface GISDatabaseMnager : NSObject
{
   GISAppDelegate *appDelegate;
}

@property (nonatomic, assign)sqlite3 *subscriptionDB;
-(void)closeDB;
+ (id) sharedDataManager;
- (void)reloadTheDatabaseFile;
- (BOOL) executeInsertQuery:(NSString *)query;
- (BOOL) executeCreateTableQuery:(NSString *)query;
- (BOOL) deleteTable:(NSString *)tableName;
- (BOOL) executeUpdateQuery:(NSString *)query;
-(void)insertLoginData:(NSDictionary*)loginDict;
-(void)insertDropDownData:(NSDictionary*)loginDict Query:(NSString *)query;
-(NSArray *)getDropDownArray:(NSString *)query;
-(NSArray *)geLoginArray:(NSString *)query;

-(void)insertContactInfoData:(NSDictionary*)contactInfoDict;
-(NSArray *)getContactsArray:(NSString *)query;
-(void)deleteRequestId:(NSString *)requestId;

@end
