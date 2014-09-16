//
//  GISAddUpdateJobsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 09/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAddUpdateJobsViewController.h"
#import "GISAddUpdateJobCell.h"

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

#import "GISConstants.h"
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
    return 700;
}

-(IBAction)closeButtonPressed:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeJobHistory" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)saveButtonPressed:(id)sender
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
