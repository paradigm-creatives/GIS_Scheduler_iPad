//
//  GISFindRequestJobsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 04/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISFindRequestJobsViewController.h"
#import "GISConstants.h"
#import "GISFindRequestJobs_Cell.h"
#import "GISJobAssignmentViewController.h"
#import "GISDatabaseManager.h"
#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "GISJSONProperties.h"
#import "GISUtility.h"
#import "GISLoadingView.h"
#import "GISStoreManager.h"

@interface GISFindRequestJobsViewController ()

@end

@implementation GISFindRequestJobsViewController

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
     requestId_label.text=NSLocalizedStringFromTable(@"Request_ID", TABLE, nil);
    self.title=NSLocalizedStringFromTable(@"Find_Requests_Jobs", TABLE, nil);
    
    findReqObj=[[GISFindRequestJobsObject alloc]init];
    findReqObj.weekDays_dictionary=[[NSMutableDictionary alloc]init];
    
    requestorType_array=[[NSMutableArray alloc]init];
    requestor_array=[[NSMutableArray alloc]init];
    registeredConsumers_array=[[NSMutableArray alloc]init];
    generalLocation_array=[[NSMutableArray alloc]init];
    eventType_array=[[NSMutableArray alloc]init];
    payLevel_array=[[NSMutableArray alloc]init];
    primaryAudience_array=[[NSMutableArray alloc]init];
    model_array=[[NSMutableArray alloc]init];
    serviceProviderType_array=[[NSMutableArray alloc]init];
    serviceProvider_array=[[NSMutableArray alloc]init];
    payType_array=[[NSMutableArray alloc]init];
    billLevel_array=[[NSMutableArray alloc]init];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [findReqJobs_tableView reloadData];
    self.navigationItem.hidesBackButton=YES;
    
    NSString *generalLocation_statement = [[NSString alloc]initWithFormat:@"select * from TBL_GENERAL_LOCATION  ORDER BY ID DESC;"];
    generalLocation_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:generalLocation_statement] mutableCopy];
    
    NSString *eventCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_EVENT_TYPE;"];
    eventType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:eventCode_statement] mutableCopy];
    
    payLevel_array=[[GISStoreManager sharedManager]getPayLevelObjects];
    billLevel_array=[[GISStoreManager sharedManager]getBillLevelObjects];
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProvider_array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    serviceProviderType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    NSString *payType_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
    payType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
    
    NSString *primaryAudience_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PRIMARY_AUDIENCE;"];
    primaryAudience_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:primaryAudience_statement] mutableCopy];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
    
        GISFindRequestJobs_Cell *cell=(GISFindRequestJobs_Cell *)[tableView dequeueReusableCellWithIdentifier:@"GISFindReqJobs_ReqDataCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISFindReqJobs_ReqDataCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.startDate_Answer_label_.text=[GISUtility returningstring:findReqObj.startDate_string];
        cell.endDate_Answer_label_.text=[GISUtility returningstring:findReqObj.endDate_string];
        cell.startTime_Answer_label_.text=[GISUtility returningstring:findReqObj.startTime_string];
        cell.endTime_Answer_label_.text=[GISUtility returningstring:findReqObj.endTime_string];
        cell.requestorType_Answer_label_.text=[GISUtility returningstring:findReqObj.requestorType_string];
        cell.requestor_Answer_label_.text=[GISUtility returningstring:findReqObj.requestor_string];
        cell.registeredConsumer_Answer_label_.text=[GISUtility returningstring:findReqObj.registeredConsumers_string];
        cell.generalLocation_Answer_label_.text=[GISUtility returningstring:findReqObj.generalLocation_string];
        cell.eventType_Answer_label_.text=[GISUtility returningstring:findReqObj.evenyType_string];
        cell.payLevel_Answer_label_.text=[GISUtility returningstring:findReqObj.payLevel_string];
        cell.primaryAudience_Answer_label_.text=[GISUtility returningstring:findReqObj.primaryAudience_string];
        cell.model_Answer_label_.text=[GISUtility returningstring:findReqObj.model_string];
        
        
        
        if ([findReqObj.openToPublic_string length])
        {
            if ([findReqObj.openToPublic_string isEqualToString:@"1"]) {
                [cell.openToPublic_Yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"]];
                [cell.openToPublic_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"] ];
            }
            else
            {
                [cell.openToPublic_Yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"] ];
                [cell.openToPublic_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
            }
        }
        
        return cell;
    }
    
    GISFindRequestJobs_Cell *cell=(GISFindRequestJobs_Cell *)[tableView dequeueReusableCellWithIdentifier:@"GISFindReqJobs_JobDataToSearch_Cell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISFindReqJobs_JobDataToSearch_Cell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.startDate_JobData_Answer_label_.text=[GISUtility returningstring:findReqObj.startDate_JobData_string];
    cell.endDate_JobData_Answer_label_.text=[GISUtility returningstring:findReqObj.endDate_JobData_string];
    cell.startTime_JobData_Answer_label_.text=[GISUtility returningstring:findReqObj.startTime_JobData_string];
    cell.endTime_JobData_Answer_label_.text=[GISUtility returningstring:findReqObj.endTime_JobData_string];
    cell.serviceProviderType_Answer_label_.text=[GISUtility returningstring:findReqObj.serviceProviderType_string];
    cell.serviceProvider_Answer_label_.text=[GISUtility returningstring:findReqObj.serviceProvider_string];
    cell.payType_Answer_label_.text=[GISUtility returningstring:findReqObj.payType_string];
    cell.createdBy_Answer_label_.text=[GISUtility returningstring:findReqObj.createdBy_string];
    cell.payLevel_JobDate_Answer_label_.text=[GISUtility returningstring:findReqObj.payLevel_JobData_string];
    cell.billLevel_Answer_label_.text=[GISUtility returningstring:findReqObj.billLevel_string];
    cell.cancelDate_Answer_label_.text=[GISUtility returningstring:findReqObj.cancelDate_string];
    for (int j=1; j<=7; j++) {
        NSString *str=[findReqObj.weekDays_dictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)j]];
        if ([str isEqualToString:@"Monday"]) {
            cell.monday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Tuesday"]) {
            cell.tuesday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Wednesday"]) {
            cell.wednesday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Thursday"]) {
            cell.thursday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Friday"]) {
            cell.friday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Saturday"]) {
            cell.saturday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([str isEqualToString:@"Sunday"]) {
            cell.sunday_ImageView_.image=[UIImage imageNamed:@"checked.png"];
        }
    }

    if ([findReqObj.filled_string length])
    {
        if ([findReqObj.filled_string isEqualToString:@"1"]) {
            [cell.filled_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
            [cell.filled_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
        }
        else
        {
            [cell.filled_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
            [cell.filled_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
        }
    }
    if ([findReqObj.outAgency_string length])
    {
        if ([findReqObj.outAgency_string isEqualToString:@"1"]) {
            [cell.outAgency_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
            [cell.outAgency_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
        }
        else
        {
            [cell.outAgency_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
            [cell.outAgency_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
        }
    }
    if ([findReqObj.timely_string length])
    {
        if ([findReqObj.timely_string isEqualToString:@"1"]) {
            [cell.timely_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"]];
            [cell.timely_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
        }
        else
        {
            [cell.timely_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
            [cell.timely_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"]];
        }
    }
    if ([findReqObj.cancelled_string length])
    {
        if ([findReqObj.cancelled_string isEqualToString:@"1"]) {
            [cell.canceled_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"] ];
            [cell.canceled_no_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"] ];
        }
        else
        {
            [cell.canceled_yes_ImageView setImage:[UIImage imageNamed:@"radio_button_empty"]];
            [cell.canceled_no_ImageView setImage:[UIImage imageNamed:@"radio_button_filled"]];
        }
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISFindRequestJobs_Cell *cell=(GISFindRequestJobs_Cell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==0) {
        return cell.frame.size.height;
    }
    return 700;
}

-(void)search_ButtonPressed:(id)sender
{
    appDelegate.isFromViewEditService = NO;
    GISJobAssignmentViewController *detailViewController = (GISJobAssignmentViewController *)[[GISJobAssignmentViewController alloc]initWithNibName:@"GISJobAssignmentViewController" bundle:nil];
    detailViewController.view_string = kFindRequestJobs_Screen;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(IBAction)pickerButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    id tempCellRef=(GISFindRequestJobs_Cell *)button.superview.superview.superview;
    GISFindRequestJobs_Cell *findReqJobsCell=(GISFindRequestJobs_Cell *)tempCellRef;
    
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    
    if([sender tag]==1)
    {
        btnTag=1;
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==2)
    {
        btnTag=2;
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==3)
    {
        btnTag=3;
        tableViewController1.view_String=@"timesdates";
    }
    else if ([sender tag]==4)
    {
        btnTag=4;
        tableViewController1.view_String=@"timesdates";
        
    }
    else if([sender tag]==5)
    {
        btnTag=5;
        tableViewController1.popOverArray=requestorType_array;
    }
    else if([sender tag]==6)
    {
        btnTag=6;
        tableViewController1.popOverArray=requestor_array;
    }
    else if([sender tag]==7)
    {
        btnTag=7;
        tableViewController1.popOverArray=registeredConsumers_array;
    }
    else if([sender tag]==8)
    {
        btnTag=8;
        tableViewController1.popOverArray=generalLocation_array;
    }
    else if([sender tag]==9)
    {
        btnTag=9;
        tableViewController1.popOverArray=eventType_array;
    }
    else if([sender tag]==10)
    {
        btnTag=10;
        tableViewController1.popOverArray=payLevel_array;
    }
    else if([sender tag]==11)
    {
        btnTag=11;
        tableViewController1.popOverArray=primaryAudience_array;
    }
    else if([sender tag]==12)
    {
        btnTag=12;
        tableViewController1.popOverArray=model_array;
    }
    else if([sender tag]==13)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==14)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==15)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"timesdates";
    }
    else if([sender tag]==16)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"timesdates";
    }
    else if([sender tag]==17)
    {
        btnTag=[sender tag];
        tableViewController1.popOverArray=serviceProviderType_array;
    }
    else if([sender tag]==18)
    {
        btnTag=[sender tag];
        tableViewController1.popOverArray=serviceProvider_array;
    }
    else if([sender tag]==19)
    {
        btnTag=[sender tag];
        tableViewController1.popOverArray=payType_array;
    }
    else if([sender tag]==20)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==21)
    {
        btnTag=[sender tag];
        tableViewController1.popOverArray=payLevel_array;
    }
    else if([sender tag]==22)
    {
        btnTag=[sender tag];
        tableViewController1.popOverArray=billLevel_array;
    }
    else if([sender tag]==23)
    {
        btnTag=[sender tag];
        tableViewController1.view_String=@"datestimes";
    }
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 210);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+115, button.frame.origin.y+24, 1, 1) inView:findReqJobsCell.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];
    
    if(btnTag==1)
    {
        findReqObj.startDate_string=value_str;
    }
    else if(btnTag==2)
    {
        findReqObj.endDate_string=value_str;
    }
    else if(btnTag==3)
    {
        findReqObj.startTime_string=value_str;
    }
    else if(btnTag==4)
    {
        findReqObj.endTime_string=value_str;
    }
    else if(btnTag==5)
    {
        findReqObj.requestorType_string=value_str;
    }
    else if(btnTag==6)
    {
        findReqObj.requestor_string=value_str;
    }
    else if(btnTag==7)
    {
        findReqObj.registeredConsumers_string=value_str;
    }
    else if(btnTag==8)
    {
        findReqObj.generalLocation_string=value_str;
    }
    else if(btnTag==9)
    {
        findReqObj.evenyType_string=value_str;
    }
    else if(btnTag==10)
    {
        findReqObj.payLevel_string=value_str;
    }
    else if(btnTag==11)
    {
        findReqObj.primaryAudience_string=value_str;
    }
    else if(btnTag==12)
    {
        findReqObj.model_string=value_str;
    }
    else if(btnTag==13)
    {
        findReqObj.startDate_JobData_string=value_str;
    }
    else if(btnTag==14)
    {
        findReqObj.endDate_JobData_string=value_str;
    }
    else if(btnTag==15)
    {
        findReqObj.startTime_JobData_string=value_str;
    }
    else if(btnTag==16)
    {
        findReqObj.endTime_JobData_string=value_str;
    }
    else if(btnTag==17)
    {
        findReqObj.serviceProviderType_string=value_str;
    }
    else if(btnTag==18)
    {
        findReqObj.serviceProvider_string=value_str;
    }
    else if(btnTag==19)
    {
        findReqObj.payType_string=value_str;
    }
    else if(btnTag==20)
    {
        findReqObj.createdBy_string=value_str;
    }
    else if(btnTag==21)
    {
        findReqObj.payLevel_JobData_string=value_str;
    }
    else if(btnTag==22)
    {
        findReqObj.billLevel_string=value_str;
    }
    else if(btnTag==23)
    {
        findReqObj.cancelDate_string=value_str;
    }
    [findReqJobs_tableView reloadData];
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)weekDays_ButtonPressed:(id)sender
{
    if ([findReqObj.weekDays_dictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]]){
        [findReqObj.weekDays_dictionary removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
        if ([sender tag]==1) {
            //findReqObj.monday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==2) {
            //findReqObj.tuesday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==3) {
            //wednesday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==4) {
            //thursday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==5) {
            //findReqObj.friday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==6) {
            //findReqObj.saturday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
        else if ([sender tag]==7) {
            //findReqObj.sunday_ImageView.image=[UIImage imageNamed:@"unchecked"];
        }
    }
    else{
        if ([sender tag]==1) {
            [findReqObj.weekDays_dictionary setValue:@"Monday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            //findReqObj.monday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==2) {
            [findReqObj.weekDays_dictionary setValue:@"Tuesday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            //findReqObj.tuesday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==3) {
            [findReqObj.weekDays_dictionary setValue:@"Wednesday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            //findReqObj.wednesday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==4) {
            [findReqObj.weekDays_dictionary setValue:@"Thursday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            //findReqObj.thursday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==5) {
            [findReqObj.weekDays_dictionary setValue:@"Friday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            //findReqObj.friday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==6) {
            [findReqObj.weekDays_dictionary setValue:@"Saturday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            //findReqObj.saturday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
        else if ([sender tag]==7) {
            [findReqObj.weekDays_dictionary setValue:@"Sunday" forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
            //findReqObj.sunday_ImageView.image=[UIImage imageNamed:@"checked.png"];
        }
    }
    [findReqJobs_tableView reloadData];
    NSLog(@"----week Day dict-->%@",[findReqObj.weekDays_dictionary description]);
}

-(IBAction)radioButton_Pressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1 || button.tag==2) {
        if (button.tag==1)
            findReqObj.openToPublic_string=@"1";
        else
            findReqObj.openToPublic_string=@"0";
    }
    else if (button.tag==3 || button.tag==4) {
        if (button.tag==3)
            findReqObj.filled_string=@"1";
        else
            findReqObj.filled_string=@"0";
    }
    else if (button.tag==5 || button.tag==6) {
        if (button.tag==5)
            findReqObj.outAgency_string=@"1";
        else
            findReqObj.outAgency_string=@"0";
    }
    else if (button.tag==7 || button.tag==8) {
        if (button.tag==7)
            findReqObj.timely_string=@"1";
        else
            findReqObj.timely_string=@"0";
    }
    else if (button.tag==9 || button.tag==10) {
        if (button.tag==9)
            findReqObj.cancelled_string=@"1";
        else
            findReqObj.cancelled_string=@"0";
    }
    [findReqJobs_tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
