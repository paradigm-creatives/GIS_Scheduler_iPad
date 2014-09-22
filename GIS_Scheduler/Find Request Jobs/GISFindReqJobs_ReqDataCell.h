//
//  FindReqJobs_ReqDataCell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 05/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISFindReqJobs_ReqDataCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *reqDataToSearch_label;
@property(nonatomic,strong) IBOutlet UILabel *startDate_label;
@property(nonatomic,strong) IBOutlet UILabel *endDate_label;
@property(nonatomic,strong) IBOutlet UILabel *startTime_label;
@property(nonatomic,strong) IBOutlet UILabel *endTime_label;
@property(nonatomic,strong) IBOutlet UILabel *requestorType_label;
@property(nonatomic,strong) IBOutlet UILabel *requestor_label;
@property(nonatomic,strong) IBOutlet UILabel *registeredConsumer_label;
@property(nonatomic,strong) IBOutlet UILabel *generalLocation_label;
@property(nonatomic,strong) IBOutlet UILabel *eventType_label;
@property(nonatomic,strong) IBOutlet UILabel *payLevel_label;
@property(nonatomic,strong) IBOutlet UILabel *primaryAudience_label;
@property(nonatomic,strong) IBOutlet UILabel *model_label;
@property(nonatomic,strong) IBOutlet UILabel *openToPublic_label;
@property(nonatomic,strong) IBOutlet UILabel *yes_openTo_label;
@property(nonatomic,strong) IBOutlet UILabel *no_openTo_label;

@property(nonatomic,strong) IBOutlet UILabel *jobDataToSearch_label;
@property(nonatomic,strong) IBOutlet UILabel *startDate_JobData_label;
@property(nonatomic,strong) IBOutlet UILabel *endDate_JobData_label;
@property(nonatomic,strong) IBOutlet UILabel *startTime_JobData_label;
@property(nonatomic,strong) IBOutlet UILabel *endTime_JobData_label;


@property(nonatomic,strong) IBOutlet UILabel *weekDays_Label;
@property(nonatomic,strong) IBOutlet UILabel *monday_Label;
@property(nonatomic,strong) IBOutlet UILabel *tuesday_Label;
@property(nonatomic,strong) IBOutlet UILabel *wednesday_Label;
@property(nonatomic,strong) IBOutlet UILabel *thursday_Label;
@property(nonatomic,strong) IBOutlet UILabel *friday_Label;
@property(nonatomic,strong) IBOutlet UILabel *saturday_Label;
@property(nonatomic,strong) IBOutlet UILabel *sunday_Label;

@property(nonatomic,strong) IBOutlet UIButton *monday_Button;
@property(nonatomic,strong) IBOutlet UIButton *tuesday_Button;
@property(nonatomic,strong) IBOutlet UIButton *wednesday_Button;
@property(nonatomic,strong) IBOutlet UIButton *thursday_Button;
@property(nonatomic,strong) IBOutlet UIButton *friday_Button;
@property(nonatomic,strong) IBOutlet UIButton *saturday_Button;
@property(nonatomic,strong) IBOutlet UIButton *sunday_Button;

@property(nonatomic,strong) IBOutlet UIImageView *monday_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *tuesday_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *wednesday_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *thursday_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *friday_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *saturday_ImageView;
@property(nonatomic,strong) IBOutlet UIImageView *sunday_ImageView;

@property(nonatomic,strong) IBOutlet UILabel *serviceProviderType_label;
@property(nonatomic,strong) IBOutlet UILabel *serviceProvider_label;
@property(nonatomic,strong) IBOutlet UILabel *filled_label;
@property(nonatomic,strong) IBOutlet UILabel *payType_label;
@property(nonatomic,strong) IBOutlet UILabel *outOrAgency_label;
@property(nonatomic,strong) IBOutlet UILabel *createdBy_label;
@property(nonatomic,strong) IBOutlet UILabel *timely_label;
@property(nonatomic,strong) IBOutlet UILabel *payLevel_JobDate_label;
@property(nonatomic,strong) IBOutlet UILabel *cancelled_label;
@property(nonatomic,strong) IBOutlet UILabel *billLevel_label;
@property(nonatomic,strong) IBOutlet UILabel *cancelDate_label;

@property(nonatomic,strong) IBOutlet UILabel *yes_filled_label;
@property(nonatomic,strong) IBOutlet UILabel *no_filled_label;


@property(nonatomic,strong) IBOutlet UILabel *yes_out_label;
@property(nonatomic,strong) IBOutlet UILabel *no_out_label;


@property(nonatomic,strong) IBOutlet UILabel *timely_timely_label;
@property(nonatomic,strong) IBOutlet UILabel *unTimely_timely_label;

@property(nonatomic,strong) IBOutlet UILabel *timely_Cancelled_label;
@property(nonatomic,strong) IBOutlet UILabel *unTimely_Cancelled_label;

@property(nonatomic,strong) IBOutlet UIButton *openToPublic_yes_button;
@property(nonatomic,strong) IBOutlet UIButton *openToPublic_no_button;

@property(nonatomic,strong) IBOutlet UIButton *filled_yes_button;
@property(nonatomic,strong) IBOutlet UIButton *filled_no_button;

@property(nonatomic,strong) IBOutlet UIButton *outAgency_yes_button;
@property(nonatomic,strong) IBOutlet UIButton *outAgency_no_button;

@property(nonatomic,strong) IBOutlet UIButton *timely_yes_button;
@property(nonatomic,strong) IBOutlet UIButton *timely_no_button;

@property(nonatomic,strong) IBOutlet UIButton *canceled_yes_button;
@property(nonatomic,strong) IBOutlet UIButton *canceled_no_button;

@property(nonatomic,strong) IBOutlet UIButton *search_button;


@property(nonatomic,strong) IBOutlet UILabel *startDate_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *endDate_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *startTime_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *endTime_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *requestorType_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *requestor_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *registeredConsumer_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *generalLocation_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *eventType_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *payLevel_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *primaryAudience_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *model_Answer_label;

@property(nonatomic,strong) IBOutlet UILabel *startDate_JobData_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *endDate_JobData_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *startTime_JobData_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *endTime_JobData_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *serviceProviderType_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *serviceProvider_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *filled_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *payType_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *outOrAgency_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *createdBy_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *payLevel_JobDate_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *billLevel_Answer_label;
@property(nonatomic,strong) IBOutlet UILabel *cancelDate_Answer_label;


@end
