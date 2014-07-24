//
//  GISPopOverTableViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 21/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISPopOverTableViewController.h"
#import "GISDropDownsObject.h"
@interface GISPopOverTableViewController ()

@end

@implementation GISPopOverTableViewController

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
- (void)viewWillAppear:(BOOL)animated
{
    self.preferredContentSize=popOverTableView.contentSize;
    [super viewWillAppear:animated];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.popOverArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"popOver"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popPver"];
    }
    GISDropDownsObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];

    cell.textLabel.text=dropDownObj.value_String;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISDropDownsObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
    [self.popOverDelegate sendTheSelectedPopOverData:dropDownObj.id_String :dropDownObj.value_String];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
