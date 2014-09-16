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
    // Do any additional setup after loading the view from its nib.
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication] delegate];
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
     jobChangeHistory_background_UIView.hidden=YES;
     jobChangeHistory_foreground_UIView.hidden=YES;
    
    
}

-(void)selectedChooseRequestNumber:(NSNotification*)notification
{
    NSDictionary *dict=[notification userInfo];
    NSMutableDictionary *paramsDict=[[NSMutableDictionary alloc]init];
    //[paramsDict setObject:[dict valueForKey:@"id"] forKey:KRequestId];
    [paramsDict setObject:@"2701" forKey:KRequestId];
    [paramsDict setObject:login_Obj.token_string forKey:kToken];
    appDelegate.chooseRequest_ID_String=[dict valueForKey:@"id"];
    [[GISServerManager sharedManager] getJobDetails_data:self withParams:paramsDict finishAction:@selector(successmethod_getJobDetails_data:) failAction:@selector(failuremethod_getJobDetails_data:)];
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
    return jobDetails_Array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
