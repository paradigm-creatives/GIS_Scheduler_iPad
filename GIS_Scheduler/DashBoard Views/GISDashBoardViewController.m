//
//  GISDashBoardViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 09/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardViewController.h"
#import "GISFonts.h"
#import "GISConstants.h"
#import "GISDashBoardCell.h"
#import "GISVIewEditRequestViewController.h"
@interface GISDashBoardViewController ()

@end

@implementation GISDashBoardViewController

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
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    
    //add the your gestureRecognizer , where to detect the touch..
    [datListView addGestureRecognizer:rightRecognizer];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    
    [datListView addGestureRecognizer:leftRecognizer];
    
    self.isMasterHide= YES;
    
    self.title=@"DashBoard";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UISegmentedControl appearance] setTintColor:UIColorFromRGB(0x00457c)];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xffffff) ,NSFontAttributeName : [GISFonts normal]} forState:UIControlStateHighlighted];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x00457c) ,NSFontAttributeName : [GISFonts normal]} forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [GISFonts normal]} forState:UIControlStateSelected];

    accountName_Label.font=[GISFonts normal];
    requestID_Label.font=[GISFonts normal];
    eventType_Label.font=[GISFonts normal];
    otherServices_Label.font=[GISFonts normal];
    earliestDate_Label.font=[GISFonts normal];
    approvalDate_Label.font=[GISFonts normal];
    approvedBy_Label.font=[GISFonts normal];
    status_Label.font=[GISFonts normal];
    scheduler_Label.font=[GISFonts normal];
    newIncomingRequest_Count_Label.font=[GISFonts normal];
    requestForModification_Count_Label.font=[GISFonts normal];
    serviceProvReqJobs_Count_Label.font=[GISFonts normal];
    newRequest_Label.font=[GISFonts small];
    inProgress_Label.font=[GISFonts small];
    onHold_Label.font=[GISFonts small];
    waitingForApproval_Label.font=[GISFonts small];
    approvedRequest_Label.font=[GISFonts small];
    incompleteRequest_Label.font=[GISFonts small];

    accountName_Label.textColor=UIColorFromRGB(0x00457c);
    requestID_Label.textColor=UIColorFromRGB(0x00457c);
    eventType_Label.textColor=UIColorFromRGB(0x00457c);
    otherServices_Label.textColor=UIColorFromRGB(0x00457c);
    earliestDate_Label.textColor=UIColorFromRGB(0x00457c);
    approvalDate_Label.textColor=UIColorFromRGB(0x00457c);
    approvedBy_Label.textColor=UIColorFromRGB(0x00457c);
    status_Label.textColor=UIColorFromRGB(0x00457c);
    scheduler_Label.textColor=UIColorFromRGB(0x00457c);
    newIncomingRequest_Count_Label.textColor=UIColorFromRGB(0x00457c);
    requestForModification_Count_Label.textColor=UIColorFromRGB(0x00457c);
    serviceProvReqJobs_Count_Label.textColor=UIColorFromRGB(0x00457c);
    newRequest_Label.textColor=UIColorFromRGB(0x333333);
    inProgress_Label.textColor=UIColorFromRGB(0x333333);
    onHold_Label.textColor=UIColorFromRGB(0x333333);
    waitingForApproval_Label.textColor=UIColorFromRGB(0x333333);
    approvedRequest_Label.textColor=UIColorFromRGB(0x333333);
    incompleteRequest_Label.textColor=UIColorFromRGB(0x333333);

}


- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return self.isMasterHide;
}

- (IBAction)hideAndUnHideMaster:(id)sender
{
    datListView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UIButton *btn = (UIButton*)sender;
    GISAppDelegate *appDelegate1 = (GISAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.isMasterHide= !self.isMasterHide;
    NSString *buttonTitle = self.isMasterHide ? @"UnHide"  : @"Hide";
    if ([buttonTitle isEqualToString:@"UnHide"])
    {
        dashBoard_UIView.hidden=NO;

        
    }
    else
    {
        dashBoard_UIView.hidden=YES;

    }
    
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    [ appDelegate1.spiltViewController.view setNeedsLayout ];
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

-(IBAction)SegmentToggle:(UISegmentedControl*)sender {
    
    if (sender.selectedSegmentIndex==0) {
    }
    else if(sender.selectedSegmentIndex==1)
    {
    }
    else if(sender.selectedSegmentIndex==2)
    {
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GISDashBoardCell *cell=(GISDashBoardCell *)[tableView dequeueReusableCellWithIdentifier:@"dashBoardCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GISDashBoardCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.accountName_Label.text=@"10008";
    cell.requestID_Label.text=@"14-8564";
    cell.eventType_Label.text=@"VRI";
    cell.otherServices_Label.text=@"Captioning";
    cell.earliestDate_Label.text=@"11/07/2014";
    cell.approvalDate_Label.text=@"11/07/2014";
    cell.approvedBy_Label.text=@"Admin";
    
    cell.scheduler_Label.text=@"David";
    if (indexPath.row%2==0) {
        cell.status_Label.backgroundColor=[UIColor yellowColor];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

-(void)pushToViewController:(int)section rowValue:(int)row{
    
    [self.navigationController popViewControllerAnimated:NO];
    
    if(section ==1 && row == 1){
        GISVIewEditRequestViewController *viewEditView=[[GISVIewEditRequestViewController alloc]initWithNibName:@"GISVIewEditRequestViewController" bundle:nil];
        [self.navigationController pushViewController:viewEditView animated:NO];
        
    }else if(section ==0 ){
        GISDashBoardViewController *dashBoardView=[[GISDashBoardViewController alloc]initWithNibName:@"GISDashBoardViewController" bundle:nil];
        [self.navigationController pushViewController:dashBoardView animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
