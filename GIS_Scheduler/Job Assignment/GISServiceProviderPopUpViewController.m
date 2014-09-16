//
//  GISServiceProviderPopUpViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 12/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISServiceProviderPopUpViewController.h"
#import "GISJobAssignmentCell.h"
#import "GISJobAssignmentViewController.h"
@interface GISServiceProviderPopUpViewController ()

@end

@implementation GISServiceProviderPopUpViewController

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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISJobAssignmentCell *cell=(GISJobAssignmentCell *)[tableView dequeueReusableCellWithIdentifier:@"SPCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISServiceProviderCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
      return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISJobAssignmentViewController *a8job=[[GISJobAssignmentViewController alloc]initWithNibName:@"GISJobAssignmentViewController" bundle:nil];
    [self.navigationController pushViewController:a8job animated:YES];
    
}

-(IBAction)doneButton_Pressed:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
