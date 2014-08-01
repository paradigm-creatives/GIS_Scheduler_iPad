//
//  GISSchedulerSPJobsObject.h
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISSchedulerSPJobsObject : NSObject

@property(nonatomic,strong)NSString *EventType_String;
@property(nonatomic,strong)NSString *endTime_String;
@property(nonatomic,strong)NSString *ServiceProviderName_String;
@property(nonatomic,strong)NSString *RequestedDate_String;
@property(nonatomic,strong)NSString *JobID_String;
@property(nonatomic,strong)NSString *JobNumber_String;
@property(nonatomic,strong)NSString *JobDate_String;
@property(nonatomic,strong)NSString *PayType_String;
@property(nonatomic,strong)NSString *startTime_String;
@property(nonatomic,strong)NSString *TotalHours_String;
@property(nonatomic,strong)NSString *GisResponse_String;


- (id)initWithStoreDictionary:(NSDictionary *)json;

@end
