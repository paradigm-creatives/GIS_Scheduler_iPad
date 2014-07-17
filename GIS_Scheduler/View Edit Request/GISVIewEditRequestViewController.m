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
#import "GISFonts.h"
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
     [NSDictionary dictionaryWithObjectsAndKeys:[GISFonts small], NSFontAttributeName,  UIColorFromRGB(0x00457c), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[GISFonts small], NSFontAttributeName,  [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    
    GISContactsAndBillingViewController *contactsBillingView=[[GISContactsAndBillingViewController alloc]initWithNibName:@"GISContactsAndBillingViewController" bundle:nil];
    
    GISEventDetailsViewController *eventDetailsView=[[GISEventDetailsViewController alloc]initWithNibName:@"GISEventDetailsViewController" bundle:nil];
    
    GISAttendeesViewController *attendeesView=[[GISAttendeesViewController alloc]initWithNibName:@"GISAttendeesViewController" bundle:nil];
    
    GISDatesAndTimesViewController *datesAndTimesView=[[GISDatesAndTimesViewController alloc]initWithNibName:@"GISDatesAndTimesViewController" bundle:nil];
    _viewControllers=[NSArray arrayWithObjects:contactsBillingView, eventDetailsView,attendeesView,datesAndTimesView, nil];
    
    _currentController= contactsBillingView;
    
    [_mainView addSubview:_currentController.view];
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[GISFonts large],NSFontAttributeName,UIColorFromRGB(0x00457c),NSForegroundColorAttributeName, nil]];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor yellowColor]];
    UIViewController *selectedTabView=nil;
    //if (_currentController == [_viewControllers objectAtIndex:item.tag])
    {
        
        selectedTabView= [_viewControllers objectAtIndex:item.tag];
    }
    
    [_currentController.view removeFromSuperview];
    _currentController=selectedTabView;
    for (UIView *subView in _mainView.subviews)
    {
        [subView removeFromSuperview];
    }
    [_mainView addSubview:selectedTabView.view];
    [self.view bringSubviewToFront:_mainView];
    
//    switch (item.tag) {
//        case 0:
//            [_currentController.view removeFromSuperview];
//            _currentController=selectedTabView;
//            for (UIView *subView in _mainView.subviews)
//            {
//                [subView removeFromSuperview];
//            }
//            [_mainView addSubview:selectedTabView.view];
//            [self.view bringSubviewToFront:_mainView];
//            break;
//            
//        default:
//            break;
//    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
