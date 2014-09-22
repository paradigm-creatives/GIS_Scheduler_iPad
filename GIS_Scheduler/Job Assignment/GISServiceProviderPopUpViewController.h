//
//  GISServiceProviderPopUpViewController.h
//  GIS_Scheduler
//
//  Created by Paradigm on 12/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISServiceProviderPopUpViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *serviceProvider_tableView;
    
    IBOutlet UINavigationBar *navBar;
    
}
-(IBAction)doneButton_Pressed:(id)sender;
@end
