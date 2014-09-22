//
//  GISJobDetailsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//


#import "GISJobDetailsViewController.h"
#import "GISJobDetailsCell.h"
#import "GISJSONProperties.h"
#import "GISDatabaseManager.h"
#import "GISJsonRequest.h"
#import "GISServerManager.h"
#import "GISJobDetailsStore.h"
#import "GISStoreManager.h"
#import "GISConstants.h"
#import "GISAddUpdateJobsViewController.h"
#import "GISLoadingView.h"
#import "GISCreateJobs_Cell.h"
#import "GISUtility.h"
#import "GISDatesTimesDetailStore.h"
#import "PCLogger.h"
@interface GISJobDetailsViewController ()

@end

@implementation GISJobDetailsViewController

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
    //Do any additional setup after loading the view from its nib.
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    detail_mut_array=[[NSMutableArray alloc]init];
    NSString *requetId_String = [[NSString alloc]initWithFormat:@"select * from TBL_LOGIN;"];
    NSArray  *requetId_array = [[GISDatabaseManager sharedDataManager] geLoginArray:requetId_String];
    login_Obj=[requetId_array lastObject];
    
    jobDetails_Array=[[NSMutableArray alloc]init];
    filled_Unfilled_Array=[[NSMutableArray alloc]initWithObjects:@"a",@"b",@"c", nil];
    
     selected_row=999999;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showChangeJobHistoryView) name:@"changeJobHistory" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
     createJobs_UIVIew.hidden=YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
     jobChangeHistory_background_UIView.hidden=YES;
     jobChangeHistory_foreground_UIView.hidden=YES;
    
    [[GISServerManager sharedManager] serviceProviderNames_JobDetails:self withParams:nil finishAction:@selector(successmethod_serviceProviderNames_JobDetails:) failAction:@selector(failuremethod_serviceProviderNames_JobDetails:)];
}

-(void)successmethod_serviceProviderNames_JobDetails:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    
}

-(void)failuremethod_serviceProviderNames_JobDetails:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(void)selectedChooseRequestNumber:(NSNotification*)notification
{
    NSDictionary *dict=[notification userInfo];
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    //[paramsDict setObject:[dict valueForKey:@"id"] forKey:KRequestId];

    [paramsDict setObject:@"2701" forKey:KRequestId];
    [paramsDict setObject:login_Obj.token_string forKey:kToken];
    
    
    NSMutableDictionary *paramsDict1=[[NSMutableDictionary alloc]init];
    [paramsDict1 setObject:[dict valueForKey:@"id"] forKey:kID];
    [paramsDict1 setObject:login_Obj.token_string forKey:kToken];
    
    appDelegate.chooseRequest_ID_String=[dict valueForKey:@"id"];
    [[GISServerManager sharedManager] getDateTimeDetails:self withParams:paramsDict1 finishAction:@selector(successmethod_get_Date_Time:) failAction:@selector(failuremethod_get_Date_Time:)];
    
    [[GISServerManager sharedManager] getJobDetails_data:self withParams:paramsDict finishAction:@selector(successmethod_getJobDetails_data:) failAction:@selector(failuremethod_getJobDetails_data:)];
}

-(void)successmethod_get_Date_Time:(GISJsonRequest *)response
{
    GISDatesTimesDetailStore *store;
    NSLog(@"successmethod_get_Date_Time Success---%@",response.responseJson);
    
    NSDictionary *saveUpdateDict;
    NSArray *responseArray= response.responseJson;
    saveUpdateDict = [responseArray lastObject];
    
    if ([[saveUpdateDict objectForKey:kStatusCode] isEqualToString:@"200"]) {
        
        [[GISStoreManager sharedManager]removeDateTimes_detail_Objects];
        
        store=[[GISDatesTimesDetailStore alloc]initWithStoreDictionary:response.responseJson];
        [detail_mut_array removeAllObjects];
        detail_mut_array= [[GISStoreManager sharedManager]getDateTimes_detail_Objects];
        [self sortTheDatesAndTimes];
        
        [createJObs_tableView reloadData];
    }else{
        
        [self removeLoadingView];
        [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    }
}


-(void)failuremethod_get_Date_Time:(GISJsonRequest *)response
{
    NSLog(@"Failure");
    [self removeLoadingView];
    [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"request_failed",TABLE, nil)];
    
}

-(void)sortTheDatesAndTimes
{
    [self deleteDuplicates];
    NSDateFormatter *date_formatter=[[NSDateFormatter alloc]init];
    [date_formatter setDateFormat:@"MM/dd/yyyy"];
    NSArray *sortedArray;
    sortedArray = [detail_mut_array sortedArrayUsingComparator:^NSComparisonResult(GISDatesAndTimesObject *a,GISDatesAndTimesObject *b) {
        
        NSDate *first = [date_formatter dateFromString:a.date_String];
        NSDate *second = [date_formatter dateFromString:b.date_String];
        return [first compare:second];
    }];
    [detail_mut_array removeAllObjects];
    detail_mut_array = [sortedArray mutableCopy];
}

-(void)deleteDuplicates
{
    int count=[detail_mut_array count];
    NSMutableArray *duplicates=[[NSMutableArray alloc]init];
    for(int i=0 ;i<count;i++)
    {
        for (int j=i+1; j<count; j++)
        {
            GISDatesAndTimesObject *obj1=[detail_mut_array objectAtIndex:i];
            GISDatesAndTimesObject *obj2=[detail_mut_array objectAtIndex:j];
            if ([obj1.date_String isEqualToString:obj2.date_String])
            {
                if ([obj1.startTime_String isEqualToString:obj2.startTime_String])
                {
                    if ([obj1.endTime_String isEqualToString:obj2.endTime_String])
                    {
                        [duplicates addObject:obj1];
                    }
                }
            }
        }
    }
    [detail_mut_array removeObjectsInArray:duplicates];
}

-(void)successmethod_getJobDetails_data:(GISJsonRequest *)response
{
    NSLog(@"successmethod_getRequestDetails Success---%@",response.responseJson);
    [[GISStoreManager sharedManager]removeJobDetailsObjects];
    GISJobDetailsStore *jobDetailsStore;
    jobDetailsStore=[[GISJobDetailsStore alloc]initWithJsonDictionary:response.responseJson];

    if(jobDetails_Array.count>0)
       [jobDetails_Array removeAllObjects];
    
    jobDetails_Array =[[GISStoreManager sharedManager]getJobDetailsObjects];
    [jobDetails_tableView reloadData];
}

-(void)failuremethod_getJobDetails_data:(GISJsonRequest *)response
{
    NSLog(@"Failure");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==createJObs_tableView) {
        return detail_mut_array.count;
    }
    return jobDetails_Array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==createJObs_tableView) {
        GISCreateJobs_Cell *cell=(GISCreateJobs_Cell *)[tableView dequeueReusableCellWithIdentifier:@"GISCreateJobsCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISCreateJobs_Cell" owner:self options:nil] objectAtIndex:0];
        }
        
        GISDatesAndTimesObject *detailObj;
        @try {
            if([detail_mut_array count] >0)
                detailObj=[detail_mut_array objectAtIndex:indexPath.row];
        }
        @catch (NSException *exception) {
            [[PCLogger sharedLogger] logToSave:[NSString stringWithFormat:@"Exception in DatesAndTimesDetailView CellForRowAtIndexPath %@",exception.callStackSymbols] ofType:PC_LOG_FATAL];
        }
        cell.check_uncheck_button.tag=indexPath.row;
        
        if ([createJobsCheckDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            [cell.check_uncheck_button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        else
            [cell.check_uncheck_button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        
        [cell.check_uncheck_button addTarget:self action:@selector(check_uncheck_createjobsButtonPresses:) forControlEvents:UIControlEventTouchUpInside];
        cell.dateLabel.text=detailObj.date_String;
        cell.dayLabel.text=detailObj.day_String;
        cell.startTime_Label.text=detailObj.startTime_String;
        cell.endTimeLabel.text=detailObj.endTime_String;
        return cell;
    }
    
    GISJobDetailsCell *cell=(GISJobDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"GISJobDetailsCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISJobDetailsCell" owner:self options:nil] objectAtIndex:0];
    }
    if (jobDetails_Array.count>0) {
        GISJobDetailsObject *temp_obj_jobDetails=[jobDetails_Array objectAtIndex:indexPath.row];
        cell.job_ID_Label.text=temp_obj_jobDetails.jobID_string;
        cell.job_date_Label.text=temp_obj_jobDetails.jobDate_string;
        cell.start_time_Label.text=temp_obj_jobDetails.startTime_string;
        cell.end_time_Label.text=temp_obj_jobDetails.endTime_string;
        cell.typeOf_service_Label.text=temp_obj_jobDetails.typeOfService_string;
        cell.service_provider_Label.text=temp_obj_jobDetails.jobDate_string;
        cell.payType_Label.text=temp_obj_jobDetails.payType_string;
        cell.timely_Label.text=temp_obj_jobDetails.timely_string;
        cell.billAmt_Label.text=temp_obj_jobDetails.billAmount_string;
    }

    if (selected_row==indexPath.row) {
        cell.typeOf_service_UIView.hidden=NO;
        cell.serviceProvider_UIView.hidden=NO;
        cell.payType_UIView.hidden=NO;
        
        cell.typeOf_service_EDIT_Label.text=typeOfservice_temp_string;
        cell.service_provider_EDIT_Label.text=serviceProvider_temp_string;
        cell.payType_EDIT_Label.text=payType_temp_string;
    }
    else
    {
        cell.typeOf_service_UIView.hidden=YES;
        cell.serviceProvider_UIView.hidden=YES;
        cell.payType_UIView.hidden=YES;
    }
    
    cell.editButton.tag=indexPath.row;
    cell.deleteButton.tag=indexPath.row;
    
    [cell.editButton addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


-(IBAction)pickerButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    
    if([sender tag]==111)
    {
        btnTag=111;
        tableViewController1.view_String=@"datestimes";
    }
    else if([sender tag]==222)
    {
        btnTag=222;
    }
    else if([sender tag]==333)
    {
        btnTag=333;
    }
    else if([sender tag]==444)
    {
        // Search Button Action
    }
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 150);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+105, button.frame.origin.y+24, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:2.0];
    if (btnTag==111)
    {
    }
}

-(void)editButtonPressed:(id)sender
{
    NSLog(@"tag--%d",[sender tag]);
    selected_row=[sender tag];
    
    GISJobDetailsObject *tempObj=[jobDetails_Array objectAtIndex:[sender tag]];
    serviceProvider_temp_string=tempObj.serviceProvider_string;
    typeOfservice_temp_string=tempObj.typeOfService_string;
    payType_temp_string=tempObj.payType_string;
    
    [jobDetails_tableView reloadData];
}


-(void)deleteButtonPressed:(id)sender
{
    UIAlertView *alertVIew = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) message:NSLocalizedStringFromTable(@"do you want to delete", TABLE, nil) delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertVIew.tag = [sender tag];
    alertVIew.delegate = self;
    [alertVIew show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        GISJobDetailsObject *jobObj = [jobDetails_Array objectAtIndex:alertView.tag];
        if([jobObj.jobID_string length])
        {
            currentObjTag_toDelete=alertView.tag;
        }
        else
        {
            [jobDetails_Array removeObjectAtIndex:alertView.tag];
            [jobDetails_tableView reloadData];
        }
    }
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)addNewJob_buttonPressed:(id)sender
{
    GISAddUpdateJobsViewController *jobaddUpdate=[[GISAddUpdateJobsViewController alloc]initWithNibName:@"GISAddUpdateJobsViewController" bundle:nil];
    [self presentViewController:jobaddUpdate animated:YES completion:nil];
}


-(IBAction)nextButtonPressed:(id)sender
{
    
    
}
-(IBAction)jobHistory_TitleButtonPressed:(id)sender
{
    jobChangeHistory_background_UIView.hidden=YES;
    jobChangeHistory_foreground_UIView.hidden=YES;
    if ([sender tag]==1)//Cancel Button
    {
        
    }
    else//Done Button
    {
        
    }
    
}
-(void)showChangeJobHistoryView
{
    jobChangeHistory_background_UIView.hidden=NO;
    jobChangeHistory_foreground_UIView.hidden=NO;
}



-(IBAction)checkAllJobs_buttonPressed:(id)sender
{
    if (isAlljobs_Checked) {
        isAlljobs_Checked=NO;
        [createJobsCheckDictionary removeAllObjects];
        [alljobs_Checked_button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    else
    {
        [alljobs_Checked_button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        
        isAlljobs_Checked=YES;
        [createJobsCheckDictionary removeAllObjects];
        //for (int i=0; i<detail_mut_array.count; i++)
        {
            //[createJobsCheckDictionary setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:[NSString stringWithFormat:@"%ld",(long)i]];
        }
        
    }
    [createJObs_tableView reloadData];
}

-(IBAction)createJobsButton_Pressed:(id)sender
{
    isAlljobs_Checked=NO;
    createJobsCheckDictionary=[[NSMutableDictionary alloc]init];
    createJobs_UIVIew.hidden=NO;
    [createJobs_Middle_UIVIew.layer setCornerRadius:10.0f];
    [createJobs_Middle_UIVIew.layer setBorderWidth:0.3f];
}

-(IBAction)cancelButtonPressed_CreateJobs:(id)sender
{
    createJobs_UIVIew.hidden=YES;
}

-(IBAction)doneButtonPressed_CreateJobs:(id)sender
{
    createJobs_UIVIew.hidden=YES;
}


-(void)check_uncheck_createjobsButtonPresses:(id)sender
{
    
    if ([createJobsCheckDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]]) {
        [createJobsCheckDictionary removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
    }
    else
    {
        [createJobsCheckDictionary setObject:[NSString stringWithFormat:@"%ld",(long)[sender tag]] forKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]]];
    }
    [createJObs_tableView reloadData];
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
