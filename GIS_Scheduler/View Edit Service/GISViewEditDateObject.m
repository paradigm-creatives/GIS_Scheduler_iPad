//
//  GISViewEditDateObject.m
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISViewEditDateObject.h"
#import "GISJSONProperties.h"

@implementation GISViewEditDateObject

@synthesize billAmount_String;
@synthesize endTime_String;
@synthesize jobDate_String;
@synthesize jobId_String;
@synthesize jobNumber_String;
@synthesize patType_String;
@synthesize serViceProvider_String;
@synthesize startTime_String;
@synthesize timely_String;
@synthesize typeOfService_String;

- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            //GisResponse_String = [self returningstring:[[json objectForKey:kSPRequestJobs_GisResponse] stringValue]];
            // if(GisResponse_String == NULL)
            //{
            //    GisResponse_String = @" ";
            // }else{
            billAmount_String = [self returningstring:[json objectForKey:kViewSchedule_BillAmount]];
            endTime_String = [json objectForKey:kViewSchedule_EndTime] == NULL?@" ":[NSString stringWithString:[json objectForKey:kViewSchedule_EndTime]];
            jobDate_String = [self returningstring:[json objectForKey:kViewSchedule_JobDate]];
            jobId_String = [self returningstring:[json objectForKey:kViewSchedule_JobID]];
            jobNumber_String = [self returningstring:[json objectForKey:kViewSchedule_JobNumber]];
            patType_String = [self returningstring:[json objectForKey:kViewSchedule_PayType]];
            
            serViceProvider_String = [self returningstring:[json objectForKey:kViewSchedule_ServiceProvider]];
            startTime_String = [self returningstring:[json objectForKey:kViewSchedule_StartTime]];
            timely_String = [self returningstring:[json objectForKey:kViewSchedule_Timely]];
            typeOfService_String = [self returningstring:[json objectForKey:kViewSchedule_TypeofService]];
           
            
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
