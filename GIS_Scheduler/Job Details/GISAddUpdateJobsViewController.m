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
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    typeOfserviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    serviceProvider_ID_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    
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
        return cell;
    }
    if (indexPath.section==1)
    {
        
        GISAddUpdateJobCell *cell=(GISAddUpdateJobCell *)[tableView dequeueReusableCellWithIdentifier:@"GISAddUpdateJobCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISBillingPaymentInfo" owner:self options:nil] objectAtIndex:0];
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
        return 53;

    return 53;
}

-(IBAction)closeButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeJobHistory" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)saveButtonPressed:(id)sender
{
    
}

-(IBAction)pickerButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    
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
    else if ([sender tag]==5)//Create Jobs View Buttons
    {
        btnTag=5;
        //tableViewController1.popOverArray=serviceProvider_Array;
    }
    else if ([sender tag]==6)//Create Jobs View Buttons
    {
        btnTag=6;
        //tableViewController1.popOverArray=payLevel_Array;
        
    }
    else if ([sender tag]==7)//Create Jobs View Buttons
    {
        btnTag=7;
        //tableViewController1.popOverArray=billLevel_Array;
        
    }
    else if([sender tag]==8)
    {
        btnTag=8;
        //tableViewController1.popOverArray=serviceProvider_Array;
    }
    else if([sender tag]==9)
    {
        btnTag=9;
    }
    else if([sender tag]==10)
    {
        btnTag=10;
    }
    else if ([sender tag]==11)//Create Jobs View Buttons
    {
        btnTag=11;
        //tableViewController1.popOverArray=serviceProvider_Array;
    }
    else if ([sender tag]==12)//Create Jobs View Buttons
    {
        btnTag=12;
        //tableViewController1.popOverArray=payLevel_Array;
        
    }
    else if ([sender tag]==13)//Create Jobs View Buttons
    {
        btnTag=13;
        //tableViewController1.popOverArray=billLevel_Array;
        
    }
    else if([sender tag]==14)
    {
        btnTag=14;
        //tableViewController1.popOverArray=serviceProvider_Array;
    }
    else if([sender tag]==15)
    {
        btnTag=15;
    }
    else if([sender tag]==16)
    {
        btnTag=16;
    }
    else if ([sender tag]==17)//Create Jobs View Buttons
    {
        btnTag=17;
        //tableViewController1.popOverArray=serviceProvider_Array;
    }
    else if ([sender tag]==18)//Create Jobs View Buttons
    {
        btnTag=18;
        //tableViewController1.popOverArray=payLevel_Array;
    }
    
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 210);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+125, button.frame.origin.y+82, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];
    
    if(btnTag==1)
    {
        //jobDate_Answer_Label.text=value_str;
        
    }
    else if(btnTag==2)
    {
        //serviceProvider_Answer_Label.text=value_str;
    }
    else if(btnTag==3)
    {
    }
    else if(btnTag==4)
    {
        // Search Button Action
    }
    else if (btnTag==5)
    {
        //typeOfServiceProviders_Answer_Label.text=value_str;
    }
    else if (btnTag==6)
    {
        //payLevel_Answer_Label.text=value_str;
    }
    else if (btnTag==7)
    {
        //billLevel_Answer_Label.text=value_str;
    }
    else if(btnTag==8)
    {
        //serviceProvider_Answer_Label.text=value_str;
    }
    else if(btnTag==9)
    {
    }
    else if(btnTag==10)
    {
        // Search Button Action
    }
    else if (btnTag==11)
    {
        //typeOfServiceProviders_Answer_Label.text=value_str;
    }
    else if (btnTag==12)
    {
        //payLevel_Answer_Label.text=value_str;
    }
    else if (btnTag==13)
    {
        //billLevel_Answer_Label.text=value_str;
    }
    else if(btnTag==14)
    {
        //serviceProvider_Answer_Label.text=value_str;
    }
    else if(btnTag==15)
    {
    }
    else if(btnTag==16)
    {
        // Search Button Action
    }
    else if (btnTag==17)
    {
        //typeOfServiceProviders_Answer_Label.text=value_str;
    }
    else if (btnTag==18)
    {
        //payLevel_Answer_Label.text=value_str;
    }
}

-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}
-(IBAction)radioButton_Pressed:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
