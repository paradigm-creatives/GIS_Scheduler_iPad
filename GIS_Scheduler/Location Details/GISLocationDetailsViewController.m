//
//  GISLocationDetailsViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLocationDetailsViewController.h"
#import "GISLocationDetailsCell.h"

@interface GISLocationDetailsViewController ()

@end

@implementation GISLocationDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISLocationDetailsCell *locationCell;
    
    locationCell=(GISLocationDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return locationCell.frame.size.height;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISLocationDetailsCell *cell;
        cell=(GISLocationDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"GISLocationDetailsCell" owner:self options:nil]objectAtIndex:0];
        }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    return cell;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
