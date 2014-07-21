//
//  Utils.m
//  Gallaudet-Interpreting-Service
//
//Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(BOOL)isNetworkAvailable
{
    BOOL isAvailabale = FALSE;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if ((internetStatus == ReachableViaWiFi) || (internetStatus == ReachableViaWWAN)) {
        isAvailabale = TRUE;
    } else {
        isAvailabale = FALSE;
    }
    return isAvailabale;
}

@end
