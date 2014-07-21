//
//  GISStoreManager.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 05/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GISLoginDetailsObject.h"

@interface GISStoreManager : NSObject
+ (GISStoreManager *)sharedManager;
- (BOOL)addLoginObject:(GISLoginDetailsObject*)loginObject;
- (NSMutableArray*)getLoginObjects;
- (void)removeLoginObjects;
@end
