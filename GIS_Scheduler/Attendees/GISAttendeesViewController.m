//
//  GISAttendeesViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAttendeesViewController.h"
#import "GISAttendeesTopCell.h"
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        GISAttendeesTopCell *topcell=(GISAttendeesTopCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return topcell.frame.size.height;
    }
    
    return 158;
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
