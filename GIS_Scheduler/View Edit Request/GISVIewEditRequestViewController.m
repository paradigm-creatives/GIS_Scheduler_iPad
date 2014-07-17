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
    GISEventDetailsViewController *eventDetailsView=[[GISEventDetailsViewController alloc]initWithNibName:@"GISEventDetailsViewController" bundle:nil];
    _viewControllers=[NSArray arrayWithObjects: eventDetailsView, nil];
    _currentController= eventDetailsView;
    [_mainView addSubview:_currentController.view];
    
    [self setItemFont:_contactItem];
    [self setItemFont:_eventDetailsItem];
    [self setItemFont:_attendeesItem];
    [self setItemFont:_locationdetaislItem];
    [self setItemFont:_datesItem];
    [self setItemFont:_jobdetailsItem];
    [self setItemFont:_summarYItem];
    [self setItemFont:_commentsItem];
    
    self.navigationItem.title = @"View/Edit Service Request";
    
}

-(void)setItemFont:(UITabBarItem *)tabbarItem{
    
    [tabbarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          UIColorFromRGB(0x00457c), NSForegroundColorAttributeName,
                                          [GISFonts tiny], NSFontAttributeName, nil]
                                forState:UIControlStateNormal];//[NSValue  valueWithUIOffset:UIOffsetMake(0,0)], NSShadowAttributeName,
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    UIViewController *selectedTabView=nil;
    if (_currentController == [_viewControllers objectAtIndex:0]) {
        
        selectedTabView= [_viewControllers objectAtIndex:0];
    }
    
    switch (item.tag) {
        case 0:
            [_currentController.view removeFromSuperview];
            _currentController=selectedTabView;
            for (UIView *subView in _mainView.subviews)
            {
                [subView removeFromSuperview];
            }
            [_mainView addSubview:selectedTabView.view];
            [self.view bringSubviewToFront:_mainView];
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
