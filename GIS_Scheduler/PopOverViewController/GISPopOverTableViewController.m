//
//  GISPopOverTableViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 21/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISPopOverTableViewController.h"
#import "GISDropDownsObject.h"
#import "GISConstants.h"

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
    
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.preferredContentSize=popOverTableView.contentSize;
    popOverTableView.delegate = self;
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
    if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISDropDownsObject class]])
    {
        GISDropDownsObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        cell.textLabel.text=dropDownObj.value_String;
    }
    else
    {
        cell.textLabel.text=[self.popOverArray objectAtIndex:indexPath.row];
        
        self.tableHeightConstraint.constant = 80;
        [popOverTableView needsUpdateConstraints];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.popOverArray objectAtIndex:indexPath.row] isKindOfClass:[GISDropDownsObject class]])
    {
        GISDropDownsObject *dropDownObj=[self.popOverArray objectAtIndex:indexPath.row];
        [self.popOverDelegate sendTheSelectedPopOverData:dropDownObj.id_String value:dropDownObj.value_String];
    }
    else
    {
        [self.popOverDelegate sendTheSelectedPopOverData:@"" value:[self.popOverArray objectAtIndex:indexPath.row]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
