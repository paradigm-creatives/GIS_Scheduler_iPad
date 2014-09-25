//
//  GISAddUpdateJobsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 09/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAddUpdateJobsViewController.h"
#import "GISAddUpdateJobCell.h"
#import "GISPopOverTableViewController.h"
#import "GISConstants.h"
#import "GISStoreManager.h"
#import "GISDatabaseManager.h"
#import "Constants.h"
#import "GISJSONProperties.h"
#import "GISServerManager.h"
#import "GISLoadingView.h"
#import "GISJsonRequest.h"
#import "GISUtility.h"
@interface GISAddUpdateJobsViewController ()

@end

@implementation GISAddUpdateJobsViewController

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
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [addUpdateJobs_tableView reloadData];
    self.navigationItem.hidesBackButton=YES;
    addUpdateObj=[[GISAddUpdateObject alloc]init];
    callInTime_Array=[[NSMutableArray alloc]init];
    payLevel_Array=[[NSMutableArray alloc]init];
    typeOfserviceProvider_Array=[[NSMutableArray alloc]init];
    serviceProvider_ID_Array=[[NSMutableArray alloc]init];
    cancelled_Array=[[NSMutableArray alloc]initWithObjects:@"Timely",@"UnTimely" ,nil];
    payLevel_Array=[[NSMutableArray alloc]init];
    payType_Array=[[NSMutableArray alloc]init];
    parking_Array=[[NSMutableArray alloc]init];
    billAmt_Array=[[NSMutableArray alloc]init];
    mileage_Array=[[NSMutableArray alloc]init];
    invoice_Array=[[NSMutableArray alloc]init];
    amtpaid_Array=[[NSMutableArray alloc]init];
    billDate_Array=[[NSMutableArray alloc]init];
    agencyFee_Array=[[NSMutableArray alloc]init];
    payStatus_Array=[[NSMutableArray alloc]init];
    expStatus_Array=[[NSMutableArray alloc]init];
    
    payLevel_Array=[[GISStoreManager sharedManager]getPayLevelObjects];

    
    NSString *payType_statement = [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
    payType_Array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProvider_ID_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    typeOfserviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    
    payStatus_Array=[[GISStoreManager sharedManager]getPayStatus_ExpStatusObjects];
    expStatus_Array=[[GISStoreManager sharedManager]getPayStatus_ExpStatusObjects];
    payLevel_Array=[[GISStoreManager sharedManager]getPayLevelObjects];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        
        GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[tableView dequeueReusableCellWithIdentifier:@"GISAddUpdateJobCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISJobInfoCell" owner:self options:nil] objectAtIndex:0];
        }
        if ([addUpdateObj.jobDate_string length])
            cell.jobDate_answer_label.text=addUpdateObj.jobDate_string;
        if ([addUpdateObj.startTime_string length])
            cell.startTime_answer_label.text=addUpdateObj.startTime_string;
        if ([addUpdateObj.endTime_string length])
            cell.endTime_answer_label.text=addUpdateObj.endTime_string;
        if ([addUpdateObj.callInTime_string length])
            cell.callInTime_answer_label.text=addUpdateObj.callInTime_string;
        if ([addUpdateObj.payLevel_string length])
            cell.payLevel_answer_label.text=addUpdateObj.payLevel_string;
        if ([addUpdateObj.typeOfServiceProvider_string length])
            cell.typeOfServiceProvider_answer_label.text=addUpdateObj.typeOfServiceProvider_string;
        if ([addUpdateObj.serviceProvider_string length])
            cell.serviceProviderId_answer_label.text=addUpdateObj.serviceProvider_string;
        if ([addUpdateObj.cancelled_string length])
            cell.cancelled_answer_label.text=addUpdateObj.cancelled_string;
        if ([addUpdateObj.payType_string length])
            cell.payType_answer_label.text=addUpdateObj.payType_string;
        if ([addUpdateObj.outOfAgency_string length])
        {
            if ([addUpdateObj.outOfAgency_string isEqualToString:@"yes"]) {
                cell.yes_outAgency_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
                cell.no_outAgency_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
            }
            else
            {
                cell.yes_outAgency_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
                cell.no_outAgency_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
            }
            
        }
        if ([addUpdateObj.timelyandHalf_string length])
        {
            if ([addUpdateObj.timelyandHalf_string isEqualToString:@"yes"]) {
                cell.yes_timelyAndHalf_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
                cell.no_timelyAndHalf_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
            }
            else
            {
                cell.yes_timelyAndHalf_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
                cell.no_timelyAndHalf_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
            }
        }
        return cell;
    }
    if (indexPath.section==1)
    {
        
        GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[tableView dequeueReusableCellWithIdentifier:@"GISAddUpdateJobCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISBillingPaymentInfo" owner:self options:nil] objectAtIndex:0];
        }
        if ([addUpdateObj.parking_string length])
            cell.parking_textField.text=addUpdateObj.payType_string;
        if ([addUpdateObj.mileage_string length])
            cell.mileage_textField.text=addUpdateObj.mileage_string;
        if ([addUpdateObj.amtPaid_string length])
            cell.amtPaid_textField.text=addUpdateObj.amtPaid_string;
        if ([addUpdateObj.agencyFee_string length])
            cell.agencyFee_textField.text=addUpdateObj.agencyFee_string;
        if ([addUpdateObj.billAmount_string length])
            cell.billAmt_textField.text=addUpdateObj.billAmount_string;
        if ([addUpdateObj.invoice_string length])
            cell.invoice_textField.text=addUpdateObj.invoice_string;
        if ([addUpdateObj.billdate_string length])
            cell.billDate_answer_label.text=addUpdateObj.billdate_string;
        
        if ([addUpdateObj.payStatus_string length])
            cell.payStatus_answer_label.text=addUpdateObj.payStatus_string;
        if ([addUpdateObj.expStatus_string length])
            cell.expStatus_answer_label.text=addUpdateObj.expStatus_string;
        
        if ([addUpdateObj.timelyandHalf_BillPayment_string length])
        {
            if ([addUpdateObj.timelyandHalf_BillPayment_string isEqualToString:@"yes"]) {
                cell.yes_timelyAndHalf_BillingPayment_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
                cell.no_timelyAndHalf_BillingPayment_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
            }
            else
            {
                cell.yes_timelyAndHalf_BillingPayment_ImageView.image=[UIImage imageNamed:@"radio_button_empty"];
                cell.no_timelyAndHalf_BillingPayment_ImageView.image=[UIImage imageNamed:@"radio_button_filled"];
            }
            
        }
        return cell;
    }
    if (indexPath.section==2)
    {
        
        GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[tableView dequeueReusableCellWithIdentifier:@"GISAddUpdateJobCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISNotesHistoryCell" owner:self options:nil] objectAtIndex:0];
        }
        return cell;
    }
    
    GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[tableView dequeueReusableCellWithIdentifier:@"GISAddUpdateJobCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISRequestServiceProvidersCell" owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==0) {
        return cell.frame.size.height;
    }
    else if (indexPath.section==1)
        return 393;
    else if (indexPath.section==2)
        return 106;

    return 150;
}

-(IBAction)closeButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeJobHistory" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)saveButtonPressed:(id)sender
{
    [currentTextField resignFirstResponder];
    NSMutableDictionary *addJobDict;
    addJobDict=[[NSMutableDictionary alloc]init];
    
    [addJobDict setObject:[GISUtility returningstring:appDelegate.chooseRequest_ID_String] forKey:KRequestId];
    [addJobDict setObject:[GISUtility returningstring:login_Obj.requestorID_string] forKey:kLoginRequestorID];
    [addJobDict setObject:@"" forKey:kSubmitForRequest_JobId];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.jobDate_string] forKey:kEditSchedule_JobDate];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.startTime_string] forKey:kSearchReq_Result_StartTime];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.endTime_string] forKey:kSearchRequest_EndTime];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.typeOfServiceProvider_ID_string] forKey:kViewSchedule_SubroleID];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.serviceProvider_ID_string] forKey:kViewSchedule_ServiceProviderID];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.cancelled_ID_string] forKey:kCancel];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.payType_ID_string] forKey:kViewSchedule_PayTypeID];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.outOfAgency_string] forKey:kOutToAgency];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.cancelled_ID_string] forKey:kJobDetais_Timely];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.parking_string] forKey:kChooseReqDetails_parking];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.mileage_string] forKey:kMyJobs_Mileage];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.billAmount_string] forKey:kJobDetais_BillAmount];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.amtPaid_string] forKey:kAmtPaid];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.agencyFee_string ]forKey:kAgencyFee];
    [addJobDict setObject:@"" forKey:kOverrideBill];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.payStatus_ID_string] forKey:kPayStatus];
    [addJobDict setObject:[GISUtility returningstring:addUpdateObj.expStatus_ID_string] forKey:kExpenseStatus];
    [addJobDict setObject:@"" forKey:kViewSchedule_JobNotes];
    [addJobDict setObject:@"" forKey:kBillingLevelID];

    [self addLoadViewWithLoadingText:NSLocalizedStringFromTable(@"loading", TABLE, nil)];
    
    [[GISServerManager sharedManager] updateJobDetails:self withParams:addJobDict finishAction:@selector(successmethod_AddUpdateJob_data:) failAction:@selector(failuremethod_AddUpdateJob_data:)];
}


-(void)successmethod_AddUpdateJob_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
}

-(void)failuremethod_AddUpdateJob_data:(GISJsonRequest *)response
{
    [self removeLoadingView];
    NSLog(@"Failure");
}
-(IBAction)pickerButtonPressed:(id)sender
{
    [currentTextField resignFirstResponder];
    UIButton *button=(UIButton *)sender;
    GISAddUpdateJobCell *jobCell=(GISAddUpdateJobCell *)button.superview.superview.superview;
    
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
        tableViewController1.view_String=@"timesdates";
    }
    else if([sender tag]==3)
    {
        btnTag=3;
        tableViewController1.view_String=@"timesdates";
    }
    else if([sender tag]==4)
    {
        btnTag=4;
        tableViewController1.view_String=@"timesdates";
    }
    else if ([sender tag]==5)
    {
        btnTag=5;
        tableViewController1.popOverArray=callInTime_Array;
    }
    else if ([sender tag]==6)
    {
        btnTag=6;
        tableViewController1.popOverArray=typeOfserviceProvider_Array;
        
    }
    else if ([sender tag]==7)
    {
        btnTag=7;
        tableViewController1.popOverArray=serviceProvider_ID_Array;
        
    }
    else if([sender tag]==8)
    {
        btnTag=8;
        tableViewController1.popOverArray=cancelled_Array;
    }
    else if([sender tag]==9)
    {
        btnTag=9;
        tableViewController1.popOverArray=payType_Array;
    }
    else if([sender tag]==10)
    {
        btnTag=10;
    }
    else if ([sender tag]==11)
    {
        btnTag=11;
    }
    else if ([sender tag]==12)
    {
        btnTag=12;
    }
    else if ([sender tag]==13)
    {
        btnTag=13;
        
    }
    else if([sender tag]==14)
    {
        btnTag=14;
    }
    else if([sender tag]==15)
    {
        btnTag=15;
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==16)
    {
        btnTag=16;
    }
    else if ([sender tag]==17)
    {
        btnTag=17;
        tableViewController1.popOverArray=payStatus_Array;
    }
    else if ([sender tag]==18)
    {
        btnTag=18;
        tableViewController1.popOverArray=expStatus_Array;
    }
    
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 210);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+128, button.frame.origin.y+22, 1, 1) inView:jobCell.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];
    
    if(btnTag==1)
    {
        addUpdateObj.jobDate_string=value_str;
    }
    else if(btnTag==2)
    {
        addUpdateObj.startTime_string=value_str;
    }
    else if(btnTag==3)
    {
        addUpdateObj.endTime_string=value_str;
    }
    else if(btnTag==4)
    {
        addUpdateObj.callInTime_string=value_str;
        if ([addUpdateObj.callInTime_string isEqualToString:@"Timely"])
            addUpdateObj.callInTime_ID_string=@"T";
        else
            addUpdateObj.callInTime_ID_string=@"U";
    }
    else if (btnTag==5)
    {
        addUpdateObj.payLevel_string=value_str;
        addUpdateObj.payLevel_ID_string=id_str;
    }
    else if (btnTag==6)
    {
        addUpdateObj.typeOfServiceProvider_string=value_str;
        addUpdateObj.typeOfServiceProvider_ID_string=id_str;
        [serviceProvider_ID_Array removeAllObjects];
        NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO WHERE TYPE = '%@'",addUpdateObj.typeOfServiceProvider_string];
        serviceProvider_ID_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    }
    else if (btnTag==7)
    {
        addUpdateObj.serviceProvider_string=value_str;
        addUpdateObj.serviceProvider_ID_string=id_str;
    }
    else if(btnTag==8)
    {
        addUpdateObj.cancelled_string=value_str;
        addUpdateObj.cancelled_ID_string=id_str;
    }
    else if(btnTag==9)
    {
        addUpdateObj.payType_string=value_str;
        addUpdateObj.payType_ID_string=id_str;
    }
    else if(btnTag==10)
    {
    }
    else if (btnTag==11)
    {
    }
    else if (btnTag==12)
    {
    }
    else if (btnTag==13)
    {
    }
    else if(btnTag==14)
    {
    }
    else if(btnTag==15)
    {
        addUpdateObj.billdate_string=value_str;
    }
    else if(btnTag==16)
    {
    }
    else if (btnTag==17)
    {
        addUpdateObj.payStatus_string=value_str;
        addUpdateObj.payStatus_ID_string=id_str;
    }
    else if (btnTag==18)
    {
        addUpdateObj.expStatus_string=value_str;
        addUpdateObj.expStatus_ID_string=id_str;
    }
    [addUpdateJobs_tableView reloadData];
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}
-(IBAction)radioButton_Pressed:(id)sender
{
    [currentTextField resignFirstResponder];
    UIButton *button=(UIButton *)sender;
    if (button.tag==1 || button.tag==2) {
        if (button.tag==1)
            addUpdateObj.outOfAgency_string=@"yes";
        else
            addUpdateObj.outOfAgency_string=@"no";
    }
    else if (button.tag==3 || button.tag==4) {
        if (button.tag==3)
            addUpdateObj.timelyandHalf_string=@"yes";
        else
            addUpdateObj.timelyandHalf_string=@"no";
    }
    else if (button.tag==5 || button.tag==6) {
        if (button.tag==5)
            addUpdateObj.timelyandHalf_BillPayment_string=@"yes";
        else
            addUpdateObj.timelyandHalf_BillPayment_string=@"no";
    }
    [addUpdateJobs_tableView reloadData];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==1)
        addUpdateObj.parking_string=textField.text;
    else if (textField.tag==2)
        addUpdateObj.mileage_string=textField.text;
    else if (textField.tag==3)
        addUpdateObj.amtPaid_string=textField.text;
    else if (textField.tag==4)
        addUpdateObj.agencyFee_string=textField.text;
    
}

-(void)addLoadViewWithLoadingText:(NSString*)title
{
    [[GISLoadingView sharedDataManager] addLoadingAlertView:title];
    
}

-(void)removeLoadingView
{
    [[GISLoadingView sharedDataManager] removeLoadingAlertview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
