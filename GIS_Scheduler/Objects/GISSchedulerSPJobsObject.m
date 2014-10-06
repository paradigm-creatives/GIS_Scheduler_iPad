//
//  GISSchedulerSPJobsObject.m
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSchedulerSPJobsObject.h"
#import "GISJSONProperties.h"
#import "GISDropDownsObject.h"
#import "GISStoreManager.h"

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
@synthesize PayType_id_String;
@synthesize SPRequestJobID_String;

- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            //GisResponse_String = [self returningstring:[[json objectForKey:kSPRequestJobs_GisResponse] stringValue]];
           // if(GisResponse_String == NULL)
            //{
            //    GisResponse_String = @" ";
           // }else{
            if ([json objectForKey:kSPRequestJobs_GisResponse])
              GisResponse_String = [self returningstring:[json objectForKey:kSPRequestJobs_GisResponse]];
            if ([json objectForKey:kSPRequestJobs_EndTime])
            endTime_String = [json objectForKey:kSPRequestJobs_EndTime] == NULL?@" ":[NSString stringWithString:[json objectForKey:kSPRequestJobs_EndTime]];
            if ([json objectForKey:kSPRequestJobs_EventType])
            EventType_String = [self returningstring:[json objectForKey:kSPRequestJobs_EventType]];
            if ([json objectForKey:kSPRequestJobs_JobDate])
            JobDate_String = [self returningstring:[json objectForKey:kSPRequestJobs_JobDate]];
            if ([json objectForKey:kSPRequestJobs_JobID])
            JobID_String = [self returningstring:[json objectForKey:kSPRequestJobs_JobID]];
            if ([json objectForKey:kSPRequestJobs_JobNumber])
            JobNumber_String = [self returningstring:[json objectForKey:kSPRequestJobs_JobNumber]];
            if ([json objectForKey:kSPRequestJobs_PayType])
            PayType_id_String = [self returningstring:[json objectForKey:kSPRequestJobs_PayType]];
            if ([json objectForKey:kSPRequestJobs_RequestedDate])
            RequestedDate_String = [self returningstring:[json objectForKey:kSPRequestJobs_RequestedDate]];
            if ([json objectForKey:kSPRequestJobs_StartTime])
            startTime_String = [self returningstring:[json objectForKey:kSPRequestJobs_StartTime]];
            if ([json objectForKey:kSPRequestJobs_ServiceProviderName])
            ServiceProviderName_String = [self returningstring:[json objectForKey:kSPRequestJobs_ServiceProviderName]];
            if ([json objectForKey:kSPRequestJobs_TotalHours])
            TotalHours_String = [self returningstring:[json objectForKey:kSPRequestJobs_TotalHours]];
            if ([json objectForKey:kSPRequestJobs_SPRequestJobID])
            SPRequestJobID_String = [self returningstring:[json objectForKey:kSPRequestJobs_SPRequestJobID]];
            if ([json objectForKey:kSPRequestJobs_AccountName])
                _accountName_string = [self returningstring:[json objectForKey:kSPRequestJobs_AccountName]];
            if ([json objectForKey:kSPRequestJobs_BillAmount])
                _billAmount_string = [self returningstring:[json objectForKey:kSPRequestJobs_BillAmount]];
            if ([json objectForKey:kSPRequestJobs_OutToAgency])
                _outToAgency_string = [self returningstring:[json objectForKey:kSPRequestJobs_OutToAgency]];
            if ([json objectForKey:kSPRequestJobs_Location])
                _location_string = [self returningstring:[json objectForKey:kSPRequestJobs_Location]];
            if ([json objectForKey:kSPRequestJobs_RequestorName])
                _requestorName_string = [self returningstring:[json objectForKey:kSPRequestJobs_RequestorName]];
            if ([json objectForKey:kSPRequestJobs_SubRole])
                _subRoll_string = [self returningstring:[json objectForKey:kSPRequestJobs_SubRole]];
            if ([json objectForKey:kSPRequestJobs_Timely])
                _timely_string = [self returningstring:[json objectForKey:kSPRequestJobs_Timely]];
            if ([json objectForKey:kSPRequestJobs_TypeofService])
                _typeOfService_string = [self returningstring:[json objectForKey:kSPRequestJobs_TypeofService]];

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
