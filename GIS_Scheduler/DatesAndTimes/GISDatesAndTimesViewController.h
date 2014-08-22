//
//  GISDatesAndTimesViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISDatesAndTimesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *datesTimes_tableView;
    

    IBOutlet UILabel *startDate_Label;
    IBOutlet UITextField *startDate_TextField;
    
    IBOutlet UILabel *endDate_Label;
    IBOutlet UITextField *endDate_TextField;
    
    IBOutlet UILabel *startTime_Label;
    IBOutlet UITextField *startTime_TextField;
    
    IBOutlet UILabel *endTime_Label;
    IBOutlet UITextField *endTime_TextField;
    
    IBOutlet UILabel *weekDays_Label;
    IBOutlet UILabel *monday_Label;
    IBOutlet UILabel *tuesday_Label;
    IBOutlet UILabel *wednesday_Label;
    IBOutlet UILabel *thursday_Label;
    IBOutlet UILabel *friday_Label;
    IBOutlet UILabel *saturday_Label;
    IBOutlet UILabel *sunday_Label;
    
    IBOutlet UIButton *create_DateTime_Button;
    IBOutlet UIButton *create_Jobs_Button;
    IBOutlet UIButton *next_Button;

    IBOutlet UIView *weekDays_UIView;

    IBOutlet UIButton *monday_Button;
    IBOutlet UIButton *tuesday_Button;
    IBOutlet UIButton *wednesday_Button;
    IBOutlet UIButton *thursday_Button;
    IBOutlet UIButton *friday_Button;
    IBOutlet UIButton *saturday_Button;
    IBOutlet UIButton *sunday_Button;
    
    IBOutlet UIImageView *monday_ImageView;
    IBOutlet UIImageView *tuesday_ImageView;
    __weak IBOutlet UILabel *createDatesTimes_Label;
    __weak IBOutlet UILabel *viewEditDatesTimes_Label;
    IBOutlet UIImageView *wednesday_ImageView;
    IBOutlet UIImageView *thursday_ImageView;
    IBOutlet UIImageView *friday_ImageView;
    IBOutlet UIImageView *saturday_ImageView;
    IBOutlet UIImageView *sunday_ImageView;
    
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *dayLabel;
    IBOutlet UILabel *startTime_Header_Label;
    IBOutlet UILabel *endTime_header_Label;
    IBOutlet UILabel *editALL_Label;

    
}
@end
