//
//  GISServiceProviderRequestedJobsResultsViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 30/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISServiceProviderRequestedJobsResultsViewController.h"
#import "GISDashBoardSPCell.h"
#import "GISSchedulerSPJobsObject.h"
#import "GISConstants.h"

@interface GISServiceProviderRequestedJobsResultsViewController ()

@end

@implementation GISServiceProviderRequestedJobsResultsViewController

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
    
    self.isMasterHide= YES;
    self.title = NSLocalizedStringFromTable(@"Service_Provider_RequestedJobs_Results", TABLE, nil);
    
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_SPJobsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GISDashBoardSPCell *cell=(GISDashBoardSPCell *)[tableView dequeueReusableCellWithIdentifier:@"dashBoardSPCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISDashBoardSPCell" owner:self options:nil] objectAtIndex:0];
    }
    
    GISSchedulerSPJobsObject *spJobsObj = [_SPJobsArray objectAtIndex:indexPath.row];
    
    [cell.jobId_Label setText:spJobsObj.JobNumber_String];
    [cell.jobdate_Label setText:spJobsObj.JobDate_String];
    [cell.startTime_Label setText:spJobsObj.startTime_String];
    [cell.endTime_Label setText:spJobsObj.endTime_String];
    [cell.totalHours_Label setText:spJobsObj.TotalHours_String];
    [cell.eventType_Label setText:spJobsObj.EventType_String];
    [cell.serviceProviderName_Label setText:spJobsObj.ServiceProviderName_String];
    [cell.requestedDate_Label setText:spJobsObj.RequestedDate_String];
    
    
    [cell.payType_btn setTitle:spJobsObj.PayType_String forState:UIControlStateNormal];
    [cell.response_status_btn setTitle:spJobsObj.GisResponse_String forState:UIControlStateNormal];
    
    [cell.payType_btn setBackgroundImage:nil forState:UIControlStateNormal];
    [cell.response_status_btn setBackgroundImage:nil forState:UIControlStateNormal];

    [cell.payType_btn setTag:indexPath.row];
    [cell.response_status_btn setTag:indexPath.row];
    [cell.done_btn setTag:indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return self.isMasterHide;
}

- (IBAction)hideAndUnHideMaster:(id)sender
{
    datListView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UIButton *btn = (UIButton*)sender;
    GISAppDelegate *appDelegate1 = (GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.isMasterHide= !self.isMasterHide;
    NSString *buttonTitle = self.isMasterHide ? @""  : @"  "; //@""== Unhide   @"  "==Hide
    if ([buttonTitle isEqualToString:@""])
    {
        _flipView.hidden=NO;
        CGRect frame1=_flipView.frame;
        frame1.origin.x=0;
        _flipView.frame=frame1;
        
        CGRect frame2=_jobResultsTableView.frame;
        frame2.origin.x=75;
        _jobResultsTableView.frame=frame2;
        
        CGRect frame3=_horizontalview.frame;
        frame3.origin.x=75;
        _horizontalview.frame=frame3;
        self.navigationItem.hidesBackButton = YES;

    }
    else
    {
        _flipView.hidden=YES;
        CGRect frame1=_flipView.frame;
        frame1.origin.x=0;
        _flipView.frame=frame1;
        
        CGRect frame2=_jobResultsTableView.frame;
        frame2.origin.x=0;
        _jobResultsTableView.frame=frame2;
        
        CGRect frame3=_horizontalview.frame;
        frame3.origin.x=0;
        _horizontalview.frame=frame3;
        
        self.navigationItem.hidesBackButton = NO;

        
    }
    
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    [ appDelegate1.spiltViewController.view setNeedsLayout ];
    appDelegate1.spiltViewController.delegate = self;
    
    [appDelegate1.spiltViewController willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"rightSwipeHandle");
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"leftSwipeHandle");
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
