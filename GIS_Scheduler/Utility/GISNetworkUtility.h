//
//  GISNetworkUtility.h
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 21/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface GISNetworkUtility : NSObject
{
    
}

@property(nonatomic,assign)BOOL reachable;
@property(nonatomic,assign)BOOL reachableWIFI;
@property(nonatomic,assign)BOOL reachableWAN;

@property(nonatomic,strong)Reachability *internetReachable;

+ (GISNetworkUtility *)sharedManager;


-(BOOL)checkNetworkAvailability;
-(BOOL)check3G_4GAvailability;
-(BOOL)checkWifiAvailability;

@end
