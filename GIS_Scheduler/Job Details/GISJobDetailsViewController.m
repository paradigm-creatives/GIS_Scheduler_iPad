//
//  GISJobDetailsViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//


#import "GISJobDetailsViewController.h"
#import "GISJobDetailsCell.h"
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
