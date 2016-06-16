//
//  GISSummaryJobDetailsCell.h
//  GIS_Scheduler
//
//  Created by Anand on 29/10/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISSummaryJobDetailsCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIButton *edit_job_button;
@property (strong, nonatomic) IBOutlet UILabel *jobIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeOfServiceLabel;
@property (strong, nonatomic) IBOutlet UILabel *serviceProviderLabel;
@property (strong, nonatomic) IBOutlet UILabel *paytypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *timelyLabel;
@property (strong, nonatomic) IBOutlet UILabel *billAmountLabel;

@end
