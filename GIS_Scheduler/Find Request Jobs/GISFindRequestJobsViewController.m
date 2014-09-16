//
//  GISFindRequestJobsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 04/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISFindRequestJobsViewController.h"
#import "GISConstants.h"
#import "GISFindReqJobs_ReqDataCell.h"
#import "GISJobAssignmentViewController.h"
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
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [findReqJobs_tableView reloadData];
    self.navigationItem.hidesBackButton=YES;
    
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
    
        GISFindReqJobs_ReqDataCell *cell=(GISFindReqJobs_ReqDataCell *)[tableView dequeueReusableCellWithIdentifier:@"GISFindReqJobs_ReqDataCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISFindReqJobs_ReqDataCell" owner:self options:nil] objectAtIndex:0];
        }
        return cell;
    }
    
    GISFindReqJobs_ReqDataCell *cell=(GISFindReqJobs_ReqDataCell *)[tableView dequeueReusableCellWithIdentifier:@"GISFindReqJobs_JobDataToSearch_Cell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISFindReqJobs_JobDataToSearch_Cell" owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    GISFindReqJobs_ReqDataCell *cell=(GISFindReqJobs_ReqDataCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
