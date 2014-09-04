//
//  GISJobAssignmentCell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 22/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISJobAssignmentCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIButton *service_Provider_type_button;
@property(nonatomic,strong)IBOutlet UIButton *service_Provider_button;
@property(nonatomic,strong)IBOutlet UIButton *payType_button;
@property(nonatomic,strong)IBOutlet UIButton *oTA_button;

@property(nonatomic,strong)IBOutlet UIView *serviceProviderType_UIView;
@property(nonatomic,strong)IBOutlet UIView *serviceProvider_UIView;
@property(nonatomic,strong)IBOutlet UIView *payType_UIView;


@end
