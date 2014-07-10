//
//  GISDashBoardViewController.m
//  GIS_Scheduler
//
//  Created by Paradigm on 09/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDashBoardViewController.h"

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
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    
    //add the your gestureRecognizer , where to detect the touch..
    [datListView addGestureRecognizer:rightRecognizer];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    
    [datListView addGestureRecognizer:leftRecognizer];
    
    self.isMasterHide= NO;
    
}

- (BOOL)splitViewController: (UISplitViewController*)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}
- (IBAction)hideAndUnHideMaster:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        
        [self setMasterViewFrame: CGRectMake(-320,0, self.splitViewController.view.frame.size.width, self.view.bounds.size.height)];
    }];
    
    /*
    [UIView animateWithDuration:0.5 animations:^{
        
        //position off screen
        UIButton *btn = (UIButton*)sender;
        GISAppDelegate *appDelegate1 = (GISAppDelegate *)[[UIApplication sharedApplication] delegate];
        self.isMasterHide= !self.isMasterHide;
        NSString *buttonTitle = self.isMasterHide ? @"UnHide"  : @"Hide";
        [btn setTitle:buttonTitle forState:UIControlStateNormal];
        [ appDelegate1.spiltViewController.view setNeedsLayout ];
        appDelegate1.spiltViewController.delegate = self;
        [appDelegate1.spiltViewController willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
    }];
    */
    
    
}

- (void)setMasterViewFrame:(CGRect)masterViewFrame
{
    
    self.splitViewController.view.frame = masterViewFrame;
}


-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        if( !self.isMasterHide )
        {
            [UIView animateWithDuration:1.0 animations:^{
                
                [self setMasterViewFrame: CGRectMake(-self.splitViewController.view.frame.size.width+448,0, self.splitViewController.view.frame.size.width, self.view.bounds.size.height)];
            }];
            
            
            self.isMasterHide = YES;
        }
        
        NSLog(@"Swipe Left");
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        
        if( self.isMasterHide )
        {
            [UIView animateWithDuration:1.0 animations:^{
                
                [self setMasterViewFrame: CGRectMake(0,0, self.splitViewController.view.frame.size.width, self.view.bounds.size.height)];
            }];
            
            
            self.isMasterHide = NO;
        }
        
        NSLog(@"Swipe Right");
    }
    
    GISAppDelegate *appDelegate1 = (GISAppDelegate *)[[UIApplication sharedApplication] delegate];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
