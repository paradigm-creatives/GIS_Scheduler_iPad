//
//  GISDashBoardCell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 11/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface GISDashBoardCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *accountName_Label;
@property(nonatomic,strong) IBOutlet UILabel *requestID_Label;
@property(nonatomic,strong) IBOutlet UILabel *eventType_Label;
@property(nonatomic,strong) IBOutlet UILabel *otherServices_Label;
@property(nonatomic,strong) IBOutlet UILabel *earliestDate_Label;
@property(nonatomic,strong) IBOutlet UILabel *approvalDate_Label;
@property(nonatomic,strong) IBOutlet UILabel *approvedBy_Label;
@property(nonatomic,strong) IBOutlet UILabel *status_Label;
@property(nonatomic,strong) IBOutlet UILabel *scheduler_Label;
@end
