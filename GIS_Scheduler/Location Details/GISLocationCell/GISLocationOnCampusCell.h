//
//  GISLocationOnCampusCell.h
//  GIS_Scheduler
//
//  Created by Anand on 18/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISLocationOnCampusCell : UITableViewCell
    
@property(nonatomic,strong) IBOutlet UIButton *nextButton;

@property(nonatomic,strong)IBOutlet UILabel *locationDetailsOncampus_label;
@property(nonatomic,strong)IBOutlet UILabel *storeLocation_label;
@property(nonatomic,strong)IBOutlet UILabel *location_name_label;
@property(nonatomic,strong)IBOutlet UILabel *address1_label;
@property(nonatomic,strong)IBOutlet UILabel *address2_label;
@property(nonatomic,strong)IBOutlet UILabel *city_label;
@property(nonatomic,strong)IBOutlet UILabel *state_label;
@property(nonatomic,strong)IBOutlet UILabel *parking_label;
@property(nonatomic,strong)IBOutlet UILabel *garage_label;
@property(nonatomic,strong)IBOutlet UILabel *mattered_label;
@property(nonatomic,strong)IBOutlet UILabel *street_label;
@property(nonatomic,strong)IBOutlet UILabel *unknown_label;
@property(nonatomic,strong)IBOutlet UILabel *zip_label;
@property(nonatomic,strong)IBOutlet UILabel *closestmetro_label;
@property(nonatomic,strong)IBOutlet UILabel *specialProtocol_label;
@property(nonatomic,strong)IBOutlet UILabel *otherInfo_label;


@end
