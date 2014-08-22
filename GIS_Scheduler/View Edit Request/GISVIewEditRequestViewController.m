//
//  GISVIewEditRequestViewController.m
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISVIewEditRequestViewController.h"
#import "GISConstants.h"
#import "GISEventDetailsViewController.h"

#import "GISContactsAndBillingViewController.h"
#import "GISAttendeesViewController.h"
#import "GISDatesAndTimesViewController.h"
#import "GISCommentViewController.h"

#import "GISFonts.h"
#import "GISLocationDetailsViewController.h"


@interface GISVIewEditRequestViewController ()

@end

@implementation GISVIewEditRequestViewController

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
    
    self.title=@"View/Edit Service Request";
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[GISFonts normal], NSFontAttributeName,  UIColorFromRGB(0x00457c), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:[GISFonts small], NSFontAttributeName,  [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    
    GISContactsAndBillingViewController *contactsBillingView=[[GISContactsAndBillingViewController alloc]initWithNibName:@"GISContactsAndBillingViewController" bundle:nil];
    
    GISEventDetailsViewController *eventDetailsView=[[GISEventDetailsViewController alloc]initWithNibName:@"GISEventDetailsViewController" bundle:nil];
    GISLocationDetailsViewController *locationDetailsView=[[GISLocationDetailsViewController alloc]initWithNibName:@"GISLocationDetailsViewController" bundle:nil];
    _viewControllers=[NSArray arrayWithObjects: eventDetailsView,locationDetailsView, nil];
    _currentController= eventDetailsView;
    [_mainView addSubview:_currentController.view];

    GISAttendeesViewController *attendeesView=[[GISAttendeesViewController alloc]initWithNibName:@"GISAttendeesViewController" bundle:nil];
    
    GISDatesAndTimesViewController *datesAndTimesView=[[GISDatesAndTimesViewController alloc]initWithNibName:@"GISDatesAndTimesViewController" bundle:nil];

    

    
    GISCommentViewController *commentView=[[GISCommentViewController alloc]initWithNibName:@"GISCommentViewController" bundle:nil];
    
    _viewControllers=[NSArray arrayWithObjects:contactsBillingView, eventDetailsView,attendeesView,locationDetailsView,datesAndTimesView,commentView, nil];
    
    _currentController= contactsBillingView;
    
    [_mainView addSubview:_currentController.view];
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[GISFonts large],NSFontAttributeName,UIColorFromRGB(0x00457c),NSForegroundColorAttributeName, nil]];

    [self setItemFont:_contactItem];
    [self setItemFont:_eventDetailsItem];
    [self setItemFont:_attendeesItem];
    [self setItemFont:_locationdetaislItem];
    [self setItemFont:_datesItem];
    [self setItemFont:_jobdetailsItem];
    [self setItemFont:_summarYItem];
    [self setItemFont:_commentsItem];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selected.png"]];
    
    _contactItem.selectedImage = [[UIImage imageNamed:@"contact_and_billing_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _eventDetailsItem.selectedImage = [[UIImage imageNamed:@"event_details_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _attendeesItem.selectedImage = [[UIImage imageNamed:@"attendees_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _locationdetaislItem.selectedImage = [[UIImage imageNamed:@"location_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _datesItem.selectedImage = [[UIImage imageNamed:@"dates_and_times_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _jobdetailsItem.selectedImage = [[UIImage imageNamed:@"job_details_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _summarYItem.selectedImage = [[UIImage imageNamed:@"summary_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _commentsItem.selectedImage = [[UIImage imageNamed:@"comments_pressed.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIColor *titleHighlightedColor = UIColorFromRGB(0xffffff);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateHighlighted];
    
    
    self.navigationItem.title = @"View/Edit Service Request";
    
    self.requestID_Label.textColor=UIColorFromRGB(0x00457c);
    self.requestID_Label.font=[GISFonts normal];
    
    self.requestID_Answer_Label.textColor=UIColorFromRGB(0x666666);
    self.requestID_Answer_Label.font=[GISFonts small];
    
    [[UITabBar appearance] setSelectedItem:_contactItem];
}

-(void)setItemFont:(UITabBarItem *)tabbarItem{
    
    [tabbarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          UIColorFromRGB(0x00457c), NSForegroundColorAttributeName,
                                          [GISFonts tiny], NSFontAttributeName, nil]
                                forState:UIControlStateNormal];//[NSValue  valueWithUIOffset:UIOffsetMake(0,0)], NSShadowAttributeName,
    

}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor yellowColor]];
    UIViewController *selectedTabView=nil;
    
    selectedTabView= [_viewControllers objectAtIndex:item.tag];
    
    [_currentController.view removeFromSuperview];
    _currentController=selectedTabView;
    for (UIView *subView in _mainView.subviews)
    {
        [subView removeFromSuperview];
    }
    [_mainView addSubview:selectedTabView.view];
    [self.view bringSubviewToFront:_mainView];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
