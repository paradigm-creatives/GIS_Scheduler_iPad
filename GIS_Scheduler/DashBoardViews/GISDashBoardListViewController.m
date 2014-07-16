//
//  GISDashBoardListViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 09/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardListViewController.h"
#import "GISConstants.h"
#import "GISFonts.h"

@interface GISDashBoardListViewController ()

@end

@implementation GISDashBoardListViewController

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
	// Do any additional setup after loading the view.

    
    _dashBoard_ListTableView.backgroundView = nil;
    [_dashBoard_ListTableView setBackgroundColor:UIColorFromRGB(0x00457c)];

    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xeef7fa)];
    
    
    if ([_dashBoard_ListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_dashBoard_ListTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    hideClicked = NO;
    sectionhideClicked  = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1){
        
        if(hideClicked)
            return 0;
        else
            return 3;
    }
    if(section == 2){
        
        if(sectionhideClicked)
            return 0;
        else
            return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellHere"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    
    cell.backgroundColor = UIColorFromRGB(0x00457c);
    
    UIImageView *cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8,8, 25, 25)];
    UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(42,11, 250, 25)];
    cellLabel.textColor = [UIColor whiteColor];
    [cellLabel setFont:[GISFonts large]];
    
    [cell addSubview:cellImageView];
    [cell addSubview:cellLabel];
    
    if(indexPath.section == 0){
        cellLabel.text = @"Dashboard";
        cellImageView.image = [UIImage imageNamed:@"dashboard.png"];
    }else if(indexPath.section == 3){
        cellLabel.text = @"Find Requests/Jobs";
        cellImageView.image = [UIImage imageNamed:@"find_requests_jobs.png"];
    }else if(indexPath.section == 4){
        cellLabel.text = @"Logout";
        cellImageView.image = [UIImage imageNamed:@"logout.png"];
    }else if(indexPath.section == 1){
        
        cellLabel.frame = CGRectMake(55,11, 250, 25);
        
        if(indexPath.row == 0)
            cellLabel.text = @"Add Service Request";
        if(indexPath.row == 1)
            cellLabel.text = @"View/Edit Service Request";
        if(indexPath.row == 2)
            cellLabel.text = @"Service Provider Requested Jobs";
    }else if(indexPath.section == 2){
        
        cellLabel.frame = CGRectMake(55,11, 250, 25);
        
        if(indexPath.row == 0)
            cellLabel.text = @"Job Assignment";
        if(indexPath.row == 1)
            cellLabel.text = @"View/Edit Schedule";
    }

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    return 50;
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* headerView;
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(42, 16, 320, 20);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = UIColorFromRGB(0x00457c);
    headerLabel.font = [GISFonts large];
    [headerLabel setTextAlignment:NSTextAlignmentLeft];
    headerLabel.textColor = [UIColor whiteColor];
    [headerView setBackgroundColor:UIColorFromRGB(0x00457c)];
    
    UIButton *headerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    headerButton.tag = section;
    [headerButton addTarget:self action:@selector(hideRows:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerButton];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 12, 25, 25)];
    
    if(section == 1){
        
        [headerView addSubview:headerLabel];
        [headerView addSubview:headerImageView];
        headerLabel.text = @"Requests/Jobs";
        headerImageView.image = [UIImage imageNamed:@"requests_jobs.png"];
        
    }else  if(section == 2){
        
        [headerView addSubview:headerLabel];
        [headerView addSubview:headerImageView];
        
        headerLabel.text = @"Scheduling";
        headerImageView.image = [UIImage imageNamed:@"scheduling.png"];
    }else if(section == 0){
        
        UIImageView *labelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 110, 50)];
        labelImageView.image = [UIImage imageNamed:@"logo.png"] ;
        [headerView addSubview:labelImageView];
    }
    
    return headerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 80;
    if(section == 1)
        return 50;
    if(section == 2)
        return 50;
    
    return 0;
}

-(IBAction)hideRows:(id)sender{
    
    if([sender tag] == 1){
        if(!hideClicked)
            hideClicked = YES;
        else
            hideClicked = NO;
    }
    if([sender tag] == 2){
        if(!sectionhideClicked)
            sectionhideClicked = YES;
        else
            sectionhideClicked = NO;
    }
    [_dashBoard_ListTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
