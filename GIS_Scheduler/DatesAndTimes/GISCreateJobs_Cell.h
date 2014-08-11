//
//  GISCreateJobs_Cell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 11/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISCreateJobs_Cell : UITableViewCell
@property(nonatomic,strong) IBOutlet UILabel *dateLabel;
@property(nonatomic,strong) IBOutlet UILabel *dayLabel;
@property(nonatomic,strong) IBOutlet UILabel *startTime_Label;
@property(nonatomic,strong) IBOutlet UILabel *endTimeLabel;
@property(nonatomic,strong) IBOutlet UIButton *check_uncheck_button;
@end
