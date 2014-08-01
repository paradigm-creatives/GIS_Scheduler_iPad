//
//  GISSchedulerSPJobsObject.m
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSchedulerSPJobsObject.h"
#import "GISJSONProperties.h"

@implementation GISSchedulerSPJobsObject

@synthesize GisResponse_String;
@synthesize endTime_String;
@synthesize ServiceProviderName_String;
@synthesize RequestedDate_String;
@synthesize JobID_String;
@synthesize JobNumber_String;
@synthesize JobDate_String;
@synthesize PayType_String;
@synthesize startTime_String;
@synthesize TotalHours_String;
@synthesize EventType_String;


- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            //GisResponse_String = [self returningstring:[[json objectForKey:kSPRequestJobs_GisResponse] stringValue]];
           // if(GisResponse_String == NULL)
            //{
            //    GisResponse_String = @" ";
           // }else{
            GisResponse_String = [self returningstring:[json objectForKey:kSPRequestJobs_GisResponse]];
            endTime_String = [json objectForKey:kSPRequestJobs_EndTime] == NULL?@" ":[NSString stringWithString:[json objectForKey:kSPRequestJobs_EndTime]];
            EventType_String = [self returningstring:[json objectForKey:kSPRequestJobs_EventType]];
            JobDate_String = [self returningstring:[json objectForKey:kSPRequestJobs_JobDate]];
            JobID_String = [self returningstring:[json objectForKey:kSPRequestJobs_JobID]];
            JobNumber_String = [self returningstring:[json objectForKey:kSPRequestJobs_JobNumber]];
            
            PayType_String = [self returningstring:[json objectForKey:kSPRequestJobs_PayType]];
            RequestedDate_String = [self returningstring:[json objectForKey:kSPRequestJobs_RequestedDate]];
            startTime_String = [self returningstring:[json objectForKey:kSPRequestJobs_StartTime]];
            ServiceProviderName_String = [self returningstring:[json objectForKey:kSPRequestJobs_ServiceProviderName]];
            TotalHours_String = [self returningstring:[json objectForKey:kSPRequestJobs_TotalHours]];
        }
        @catch (NSException *exception) {
            NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
        }
    }
    return self;
}


-(NSString *)returningstring:(id)string
{
    if ([string isKindOfClass:[NSNull class]])
    {
        return @" ";
    }
    else
    {
        if (![string isKindOfClass:[NSString class]])
        {
            NSString *str= [string stringValue];
            return str;
        }
        else
        {
            return string;
        }
    }
    
}


@end
