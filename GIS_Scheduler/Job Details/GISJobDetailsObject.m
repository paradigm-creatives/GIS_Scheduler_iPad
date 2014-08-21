//
//  GISJobDetailsObject.m
//  GIS_Scheduler
//
//  Created by Paradigm on 19/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISJobDetailsObject.h"
#import "GISJSONProperties.h"
#import "GISUtility.h"

@implementation GISJobDetailsObject


-(GISJobDetailsObject *)initializeJObDetailsValues:(NSDictionary *)dict
{

    GISJobDetailsObject *gobj=[[GISJobDetailsObject alloc]init];
    
    if ([dict objectForKey:kJobDetais_BillAmount]) {
        gobj.billAmount_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_BillAmount]];
    }
    else if ([dict objectForKey:kJobDetais_EndTime]) {
        gobj.endTime_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_EndTime]];
    }
    else if ([dict objectForKey:kJobDetais_JobDate]) {
        gobj.jobDate_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_JobDate]];
    }
    else if ([dict objectForKey:kJobDetais_JobID]) {
        gobj.jobID_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_JobID]];
    }
    else if ([dict objectForKey:kJobDetais_JobNumber]) {
        gobj.jobNumber_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_JobNumber]];
    }
    else if ([dict objectForKey:kJobDetais_PayType]) {
        gobj.payType_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_PayType]];
    }
    else if ([dict objectForKey:kJobDetais_ServiceProvider]) {
        gobj.serviceProvider_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_ServiceProvider]];
    }
    else if ([dict objectForKey:kJobDetais_StartTime]) {
        gobj.startTime_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_StartTime]];
    }
    else if ([dict objectForKey:kJobDetais_Status]) {
        gobj.status_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_Status]];
    }
    else if ([dict objectForKey:kJobDetais_StatusCode]) {
        gobj.statusCode_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_StatusCode]];
    }
    else if ([dict objectForKey:kJobDetais_Timely]) {
        gobj.timely_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_Timely]];
    }
    else if ([dict objectForKey:kJobDetais_TypeofService]) {
        gobj.typeOfService_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_TypeofService]];
    }
    
    return gobj;
}

@end
