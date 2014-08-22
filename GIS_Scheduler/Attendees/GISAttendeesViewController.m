//
//  GISAttendeesViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAttendeesViewController.h"
#import "GISAttendeesTopCell.h"
#import "GISConstants.h"
#import "GISFonts.h"

@interface GISAttendeesViewController ()

@end

@implementation GISAttendeesViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if (section==1) {
        return 3;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        GISAttendeesTopCell *topcell=(GISAttendeesTopCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return topcell.frame.size.height;
    }
    
    return 158;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
        return 100;
    return 0;
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* headerView;
    if (section == 2)
    {
        headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        UIButton *addButton = [[UIButton alloc] init];
        addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [addButton addTarget:self
                      action:@selector(createAttendee:)
            forControlEvents:UIControlEventTouchUpInside];
        addButton.frame = CGRectMake(headerView.frame.size.width/2-50, 10.0, 20.0, 20.0);
        [headerView addSubview:addButton];
        
        UILabel* headerLabel = [[UILabel alloc] init];
        headerLabel.frame = CGRectMake(headerView.frame.size.width/2-20, addButton.frame.size.height/2+5, 80, 10);
        headerLabel.textColor = UIColorFromRGB(0x00457c);
        headerLabel.font = [UIFont boldSystemFontOfSize:12];
        headerLabel.text=NSLocalizedStringFromTable(@"add attendee", TABLE, nil);
        [headerLabel setTextAlignment:NSTextAlignmentCenter];
        [headerView addSubview:headerLabel];
        
        UIButton *nextButton = [[UIButton alloc] init];
        nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [nextButton addTarget:self
                       action:@selector(nextButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
        nextButton.frame = CGRectMake(headerView.frame.size.width/2-35, 40.0, 80.0, 30.0);
        
        [nextButton setTitle:NSLocalizedStringFromTable(@"next",TABLE, nil) forState:UIControlStateNormal];
        nextButton.backgroundColor=UIColorFromRGB(0x00457c);
        [nextButton setTitleColor:UIColorFromRGB(0xe8d4a2) forState:UIControlStateNormal];
        nextButton.titleLabel.font=[GISFonts larger];
        [nextButton.layer setCornerRadius:3.0f];
        [[nextButton layer] setMasksToBounds:YES];
        [headerView addSubview:nextButton];
        
    }
    else
    {
        headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    }
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        GISAttendeesTopCell *cell=(GISAttendeesTopCell *)[tableView dequeueReusableCellWithIdentifier:@"AttendeesCell"];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISAttendeesCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.attendee_count_Label.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        return cell;
    }
    
    GISAttendeesTopCell *cell=(GISAttendeesTopCell *)[tableView dequeueReusableCellWithIdentifier:@"AttendeesCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISAttendeesTopCell" owner:self options:nil] objectAtIndex:0];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
