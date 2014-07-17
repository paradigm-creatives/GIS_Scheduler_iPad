//
//  GISVIewEditRequestViewController.h
//  GIS_Scheduler
//
//  Created by Anand on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISVIewEditRequestViewController : UIViewController<UITabBarDelegate>

@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, retain) UIViewController *currentController;

@property (nonatomic, retain) IBOutlet UIView *mainView;

@end
