//
//  GISDatesAndTimesViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDatesAndTimesViewController.h"
#import "GISDatesTimesDetailCell.h"

#import "GISFonts.h"
#import "GISConstants.h"

@interface GISDatesAndTimesViewController ()

@end

@implementation GISDatesAndTimesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    createDatesTimes_Label.font=[GISFonts large];
    createDatesTimes_Label.textColor=UIColorFromRGB(0x00457c);
    
    viewEditDatesTimes_Label.font=[GISFonts large];
    viewEditDatesTimes_Label.textColor=UIColorFromRGB(0x00457c);
    
    editALL_Label.font=[GISFonts small];
    editALL_Label.textColor=UIColorFromRGB(0x00457c);
    
    dateLabel.font=[GISFonts small];;
    dayLabel.font=[GISFonts small];;
    startTime_Header_Label.font=[GISFonts small];;
    endTime_header_Label.font=[GISFonts small];;
    
    dateLabel.textColor=UIColorFromRGB(0x00457c);;
    dayLabel.textColor=UIColorFromRGB(0x00457c);;
    startTime_Header_Label.textColor=UIColorFromRGB(0x00457c);;
    endTime_header_Label.textColor=UIColorFromRGB(0x00457c);;
    
    
    startTime_Label .font=[GISFonts normal];
    startTime_TextField.font=[GISFonts small];
    startTime_Label.textColor=UIColorFromRGB(0x666666);
    startTime_TextField.textColor=UIColorFromRGB(0x666666);
    
    endTime_Label .font=[GISFonts normal];
    endTime_TextField.font=[GISFonts small];
    endTime_Label.textColor=UIColorFromRGB(0x666666);
    endTime_TextField.textColor=UIColorFromRGB(0x666666);
    
    startDate_Label .font=[GISFonts normal];
    startDate_TextField.font=[GISFonts small];
    startDate_Label.textColor=UIColorFromRGB(0x666666);
    startDate_TextField.textColor=UIColorFromRGB(0x666666);
    
    endDate_Label .font=[GISFonts normal];
    endDate_TextField.font=[GISFonts small];
    endDate_Label.textColor=UIColorFromRGB(0x666666);
    endDate_TextField.textColor=UIColorFromRGB(0x666666);
    
    weekDays_Label .font=[GISFonts normal];
    weekDays_Label.textColor=UIColorFromRGB(0x666666);
    
    monday_Label.font=[GISFonts small];
    tuesday_Label.font=[GISFonts small];
    wednesday_Label.font=[GISFonts small];
    thursday_Label.font=[GISFonts small];
    friday_Label.font=[GISFonts small];
    saturday_Label.font=[GISFonts small];
    sunday_Label.font=[GISFonts small];
    monday_Label.textColor=UIColorFromRGB(0x666666);
    tuesday_Label.textColor=UIColorFromRGB(0x666666);
    wednesday_Label.textColor=UIColorFromRGB(0x666666);
    thursday_Label.textColor=UIColorFromRGB(0x666666);
    friday_Label.textColor=UIColorFromRGB(0x666666);
    saturday_Label.textColor=UIColorFromRGB(0x666666);
    sunday_Label.textColor=UIColorFromRGB(0x666666);
    
    
    //create_DateTime_Button.backgroundColor=UIColorFromRGB(0x00457c);
    //[create_DateTime_Button setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    create_DateTime_Button.titleLabel.font=[GISFonts larger];
    [create_DateTime_Button.layer setCornerRadius:3.0f];
    
    //create_Jobs_Button.backgroundColor=UIColorFromRGB(0x00457c);
    //[create_Jobs_Button setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    create_Jobs_Button.titleLabel.font=[GISFonts larger];
    [create_Jobs_Button.layer setCornerRadius:3.0f];
    
    next_Button.backgroundColor=UIColorFromRGB(0x00457c);
    [next_Button setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
    next_Button.titleLabel.font=[GISFonts larger];
    [next_Button.layer setCornerRadius:3.0f];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISDatesTimesDetailCell *cell=(GISDatesTimesDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"datesTimesDetailCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISDatesTimesDetailCell" owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
