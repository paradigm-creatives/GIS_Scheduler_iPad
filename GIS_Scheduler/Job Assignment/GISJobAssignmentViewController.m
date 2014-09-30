//
//  GISJobAssignmentViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 22/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISJobAssignmentViewController.h"
#import "GISJobAssignmentCell.h"
#import "GISConstants.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"
#import "GISFilterMoreViewController.h"
#import "GISServiceProviderPopUpViewController.h"


@interface GISJobAssignmentViewController ()

@end

@implementation GISJobAssignmentViewController

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
    
    self.navigationItem.hidesBackButton = YES;
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    chooseRequest_mutArray=[[NSMutableArray alloc]init];
    NSString *requetDetails_statement = [[NSString alloc]initWithFormat:@"select * from TBL_CHOOSE_REQUEST ORDER BY ID DESC;"];
    chooseRequest_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:requetDetails_statement] mutableCopy];
    
//    //self.navigationItem.hidesBackButton = YES;
    dashBoard_UIView.hidden=YES;
//    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
//    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
//    [rightRecognizer setNumberOfTouchesRequired:1];
//    
//    //add the your gestureRecognizer , where to detect the touch..
//    [self.view addGestureRecognizer:rightRecognizer];
//    
//    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
//    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    [leftRecognizer setNumberOfTouchesRequired:1];
//    
//    [self.view addGestureRecognizer:leftRecognizer];
    
    self.title=NSLocalizedStringFromTable(@"Jobs_Assignment", TABLE, nil);
    CGRect frame1=table_UIView.frame;
    frame1.origin.x=0;
    table_UIView.frame=frame1;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.view_string isEqualToString:kFindRequestJobs_Screen]) {
        segment_UIView.hidden=YES;
        CGRect new_frame=table_UIView.frame;
        new_frame.origin.y=90;
        table_UIView.frame=new_frame;
        self.title=NSLocalizedStringFromTable(@"Find_Requests_Jobs", TABLE, nil);
    }
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed)];
//    
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.leftBarButtonItem = item;
}

-(void)backButtonPressed
{
    if (table_UIView.frame.origin.x==0) {
        [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return self.isMasterHide;
}

- (IBAction)hideAndUnHideMaster:(id)sender
{
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UIButton *btn = (UIButton*)sender;
    GISAppDelegate *appDelegate1 = (GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.isMasterHide= !self.isMasterHide;
    NSString *buttonTitle = self.isMasterHide ? @""  : @"  "; //@""== Unhide   @"  "==Hide
    if ([buttonTitle isEqualToString:@""])
    {
        dashBoard_UIView.hidden=NO;
        CGRect frame1=table_UIView.frame;
        frame1.origin.x=75;
        table_UIView.frame=frame1;
    }
    else
    {
        dashBoard_UIView.hidden=YES;
        CGRect frame1=table_UIView.frame;
        frame1.origin.x=0;
        table_UIView.frame=frame1;
    }
    
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    [appDelegate1.spiltViewController.view setNeedsLayout ];
    appDelegate1.spiltViewController.delegate = self;
    
    [appDelegate1.spiltViewController willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"rightSwipeHandle");
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"leftSwipeHandle");
    [self performSelector:@selector(hideAndUnHideMaster:) withObject:nil];
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
    GISJobAssignmentCell *cell=(GISJobAssignmentCell *)[tableView dequeueReusableCellWithIdentifier:@"AssignmentCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISJobAssignmentCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.service_Provider_type_button.tag=indexPath.row;
    cell.service_Provider_button.tag=indexPath.row;
    cell.payType_button.tag=indexPath.row;
    
    return cell;
}


-(IBAction)pickerButton_pressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    id tempCellRef=(GISJobAssignmentCell *)button.superview.superview.superview.superview.superview;
    GISJobAssignmentCell *jobAssignmentCell=(GISJobAssignmentCell *)tempCellRef;
    
    GISPopOverTableViewController *tableViewController1 = [[GISPopOverTableViewController alloc] initWithNibName:@"GISPopOverTableViewController" bundle:nil];
    tableViewController1.popOverDelegate=self;
    
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController1];
    popover.delegate = self;
    popover.popoverContentSize = CGSizeMake(340, 150);
    if([sender tag]==111 || [sender tag]==222 || [sender tag]==333 || [sender tag]==444)
    {
        if([sender tag]==111)
        {
            btnTag=111;
            tableViewController1.view_String=[GISUtility returningstring:chooseRequest_ID_answer_Label.text];
            tableViewController1.popOverArray=chooseRequest_mutArray;
        }
        else if([sender tag]==222)
        {
            btnTag=222;
            tableViewController1.view_String=@"datestimes";
            tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:from_answer_Label.text];
        }
        else if ([sender tag]==333)
        {
            btnTag=333;
            tableViewController1.view_String=@"datestimes";
            tableViewController1.dateTimeMoveUp_string=[GISUtility returningstring:to_answer_Label.text];
            
        }
        else if ([sender tag]==444)
        {
            btnTag=444;
            tableViewController1.view_String=[GISUtility returningstring:typeOfService_answer_Label.text];
            tableViewController1.popOverArray=chooseRequest_mutArray;
            
        }
        NSLog(@"-----x-->%@",NSStringFromCGRect(button.frame));
        if ([sender tag]==111)
            [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+45, 148, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        else
            [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+45, 185, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else
    {
        GISJobAssignmentCell *tempCell_JobAssignment=(GISJobAssignmentCell *)button.superview.superview.superview.superview.superview;
        
        tableViewController1.view_String=[GISUtility returningstring:chooseRequest_ID_answer_Label.text];
        tableViewController1.popOverArray=chooseRequest_mutArray;
        
        [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+button.frame.size.width+45, button.frame.origin.x+button.frame.size.width, 1, 1) inView:tempCell_JobAssignment.contentView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}


-(void)sendTheSelectedPopOverData:(NSString *)id_str value:(NSString *)value_str
{
    [self performSelector:@selector(dismissPopOverNow) withObject:nil afterDelay:0.0];
    if (btnTag==111)
    {
        chooseRequest_ID_answer_Label.text=value_str;
        
    }
    else if (btnTag==222)
    {
        from_answer_Label.text=value_str;
        if ([from_answer_Label.text length] && [to_answer_Label.text length]){
            if ([GISUtility dateComparision:from_answer_Label.text :to_answer_Label.text:YES])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"start Date alert", TABLE, nil)];
                from_answer_Label.text=@"";
            }
        }
    }
    else if (btnTag==333)
    {
        to_answer_Label.text=value_str;
        if ([from_answer_Label.text length] && [to_answer_Label.text length]){
            if ([GISUtility dateComparision:from_answer_Label.text :to_answer_Label.text:NO])
            {}
            else
            {
                [GISUtility showAlertWithTitle:NSLocalizedStringFromTable(@"gis", TABLE, nil) andMessage:NSLocalizedStringFromTable(@"end Date alert", TABLE, nil)];
                to_answer_Label.text=@"";
            }
        }
    }
    else  if (btnTag==444)
    {
        typeOfService_answer_Label.text=value_str;
        
    }
}


-(void)dismissPopOverNow
{
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)filterMore_ButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    
    GISFilterMoreViewController *tableViewController = [[GISFilterMoreViewController alloc] initWithNibName:@"GISFilterMoreViewController" bundle:nil];
    //tableViewController.popOverDelegate=self;
    //popover.popoverContentSize = CGSizeMake(433, 504);
    popover =[[UIPopoverController alloc] initWithContentViewController:tableViewController];
    popover.popoverContentSize = CGSizeMake(433, 504);
    [popover presentPopoverFromRect:CGRectMake(button.frame.origin.x+68, button.frame.origin.y+88, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

}


-(IBAction)searchButton_Pressed:(id)sender
{
    
}

-(IBAction)segment_filled_Unfilled_ValueChanged:(id)sender
{
    
}

-(IBAction)listOfServiceProviders_ButtonPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    id tempCellRef=(GISJobAssignmentCell *)button.superview.superview.superview.superview.superview;
    GISJobAssignmentCell *attendeesCell=(GISJobAssignmentCell *)tempCellRef;
    
    GISServiceProviderPopUpViewController *popOverController=[[GISServiceProviderPopUpViewController alloc]initWithNibName:@"GISServiceProviderPopUpViewController" bundle:nil];
    popover=[[UIPopoverController alloc]initWithContentViewController:popOverController];
    popover.popoverContentSize = CGSizeMake(340, 357);
    [popover presentPopoverFromRect:CGRectMake(attendeesCell.service_Provider_button.frame.origin.x+480, attendeesCell.service_Provider_button.frame.origin.y+35, 1, 1) inView:attendeesCell.contentView permittedArrowDirections:(UIPopoverArrowDirectionAny) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
