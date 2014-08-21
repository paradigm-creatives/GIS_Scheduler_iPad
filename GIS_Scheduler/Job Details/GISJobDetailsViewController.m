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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedChooseRequestNumber:) name:kselectedChooseReqNumber object:nil];
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
    GISJobDetailsStore *jobDetailsStore=[[GISJobDetailsStore alloc]initWithJsonDictionary:response.responseJson];
    
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISJobDetailsCell *cell=(GISJobDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"GISJobDetailsCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISJobDetailsCell" owner:self options:nil] objectAtIndex:0];
    }
    GISJobDetailsObject *jobDetailsohijk
    cell.job_ID_Label.text=

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

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
