//
//  GISDashBoardSPCell.h
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISDashBoardSPCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *endTime_Label;
@property(nonatomic,strong) IBOutlet UILabel *eventType_Label;
@property(nonatomic,strong) IBOutlet UILabel *jobdate_Label;
@property(nonatomic,strong) IBOutlet UILabel *jobId_Label;
@property(nonatomic,strong) IBOutlet UILabel *requestedDate_Label;
@property(nonatomic,strong) IBOutlet UILabel *serviceProviderName_Label;
@property(nonatomic,strong) IBOutlet UILabel *startTime_Label;
@property(nonatomic,strong) IBOutlet UILabel *totalHours_Label;

@property(nonatomic,strong) IBOutlet UIButton *payType_btn;
@property(nonatomic,strong) IBOutlet UIButton *response_status_btn;
@property(nonatomic,strong) IBOutlet UIButton *done_btn;

@end
