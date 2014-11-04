//
//  GISPopOverTableViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 21/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISPopOverTableViewController.h"
#import "GISDropDownsObject.h"
#import "GISConstants.h"
#import "GISServiceProviderObject.h"
#import "GISContactsInfoObject.h"
@interface GISPopOverTableViewController ()

@end

@implementation GISPopOverTableViewController

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
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.preferredContentSize=popOverTableView.contentSize;
    popOverTableView.delegate = self;
    [super viewWillAppear:animated];
    
    dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM/dd/yyyy"];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 325, 300)];
    datePicker.date = [NSDate date];
    
    if ([self.view_String isEqualToString:@"timesdates"])
    {
        datePicker.datePickerMode = UIDatePickerModeTime;
        
        [dateformatter setDateFormat:@"hh:mm a"];
        
        if ([self.dateTimeMoveUp_string length]) {
            NSDate *tempDate=[dateformatter dateFromString:self.dateTimeMoveUp_string];
            [datePicker setDate:tempDate];
        }
        else
        {
            datePicker.date=[NSDate date];
        }
        
    }
    else
    {
        datePicker.datePickerMode = UIDatePickerModeDate;

        if ([self.dateTimeMoveUp_string length]) {
            NSDate *date = [dateformatter dateFromString:self.dateTimeMoveUp_string];
            [datePicker setDate:date];
        }
        else
        {
            datePicker.date= [NSDate date];
        }
        
    }
    
    
    [datePicker addTarget:self
                   action:@selector(datePickerChange:)
         forControlEvents:UIControlEventValueChanged];
    
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        popOverTableView.scrollEnabled=NO;
    }
}

-(void)datePickerChange:(id)sender
{
    NSLog(@"Called DateTime-->%@",datePicker.date);
    [self.popOverDelegate sendTheSelectedPopOverData:@"" value:[dateformatter stringFromDate:datePicker.date]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        return 250;
    }
    return 35;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        return 1;
    }
    return [self.popOverArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.view_String isEqualToString:@"datestimes"]||[self.view_String isEqualToString:@"timesdates"]) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"popOver"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popPver"];
        }
        [cell.contentView addSubview:datePicker];
        return cell;
    }
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"popOver"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popPver"];
    }

    if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISDropDownsObject class]])
    {
        GISDropDownsObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        cell.textLabel.text=dropDownObj.value_String;
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISContactsInfoObject class]])
    {
        GISContactsInfoObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        cell.textLabel.text=dropDownObj.contactNo_String;
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISServiceProviderObject class]])
    {
        GISServiceProviderObject *spObj=[self.popOverArray objectAtIndex:indexPath.row];
        cell.textLabel.text=spObj.service_Provider_String;
    }
    else
    {
        cell.textLabel.text=[self.popOverArray objectAtIndex:indexPath.row];

        
        self.tableHeightConstraint.constant = 80;
        [popOverTableView needsUpdateConstraints];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISDropDownsObject class]])
    {
        GISDropDownsObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        [self.popOverDelegate sendTheSelectedPopOverData:dropDownObj.id_String value:dropDownObj.value_String];
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISContactsInfoObject class]])
    {
        GISContactsInfoObject *spObj=[self.popOverArray objectAtIndex:indexPath.row];
        [self.popOverDelegate sendTheSelectedPopOverData:spObj.contactTypeId_String value:spObj.contactNo_String];
    }
    else if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISServiceProviderObject class]])
    {
        GISServiceProviderObject *spObj=[self.popOverArray objectAtIndex:indexPath.row];
        [self.popOverDelegate sendTheSelectedPopOverData:spObj.id_String value:spObj.service_Provider_String];
    }else if(appDelegate.isNoofAttendees){
        
        [self.popOverDelegate sendTheSelectedPopOverData:[_noOfAttendeesIdArray objectAtIndex:indexPath.row] value:[self.popOverArray objectAtIndex:indexPath.row]];
    }
    else
    {
        [self.popOverDelegate sendTheSelectedPopOverData:@"" value:[self.popOverArray objectAtIndex:indexPath.row]];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
