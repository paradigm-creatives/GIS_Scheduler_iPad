//
//  GISNetworkUtility.m
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 21/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISNetworkUtility.h"

static GISNetworkUtility *manager = nil;

@implementation GISNetworkUtility

+ (GISNetworkUtility *)sharedManager
{
	@synchronized(self)
	{
		if ( manager == nil )
		{
			manager = [[self alloc] init];
		}
	}
	return manager;
}


-(id)init{
    self = [super init];
    if (self) {
        _internetReachable = [Reachability reachabilityForInternetConnection];
        [self reachabilityChanged:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotifications object:nil];
    }
    return self;
}


- (void)reachabilityChanged:(NSNotification *)notice {
    
    STNetworkStatus internetStatus = [_internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case STNotReachable:
        {
            
            NSLog(@"not reachable");
            _reachable = NO;
            _reachableWAN = NO;
            _reachableWIFI = NO;
            break;
        }
        case STReachableViaWiFi:
        {
            
            NSLog(@"reachable wifi");
            _reachable = YES;
            _reachableWIFI = YES;
            _reachableWAN = NO;
            
            break;
        }
        case STReachableViaWWAN:
        {
            
            NSLog(@"reachable wwan");
            _reachable = YES;
            _reachableWIFI = NO;
            _reachableWAN = YES;
            break;
        }
    }
}


-(BOOL)checkNetworkAvailability
{
    NSLog(@"_reachable is %d",_reachable);
    return _reachable;
}

-(BOOL)check3G_4GAvailability
{
    return _reachableWAN;
}

-(BOOL)checkWifiAvailability
{
    return _reachableWIFI;
}


@end
