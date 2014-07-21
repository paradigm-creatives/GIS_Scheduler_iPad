//
//  GISStoreManager.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 05/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISStoreManager.h"

@interface GISStoreManager ()
@property (nonatomic, retain) NSMutableArray *loginArray;

@end

@implementation GISStoreManager
static GISStoreManager *singletonManager = nil;

+ (GISStoreManager *)sharedManager
{
    if (singletonManager == nil) {
        singletonManager = [[self alloc]init];
    }
    return singletonManager;
}

- (id)init {
    if ([super init]) {
        _loginArray = [[NSMutableArray alloc]init];

    }
    return self;
}

#pragma mark Login Start
- (BOOL)addLoginObject:(GISLoginDetailsObject*)loginObject
{
    BOOL isAdded = FALSE;
    if (loginObject != nil) {
        [_loginArray addObject:loginObject];
        isAdded = TRUE;
    }
    return isAdded;
}

- (NSMutableArray*)getLoginObjects
{
    return [_loginArray count]?_loginArray:nil;
}
- (void)removeLoginObjects
{
    [_loginArray removeAllObjects];
}
#pragma mark Login END

@end
