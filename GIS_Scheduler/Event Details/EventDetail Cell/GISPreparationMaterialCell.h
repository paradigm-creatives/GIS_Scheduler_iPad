//
//  GISPreparationMaterialCell.h
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISPreparationMaterialCell : UITableViewCell


@property(nonatomic,strong) IBOutlet UIButton *nextButton;

@property(nonatomic,strong)IBOutlet UILabel *preparationMaterial_label;
@property(nonatomic,strong)IBOutlet UILabel *document_label;
@property(nonatomic,strong)IBOutlet UILabel *blackboardaccess_label;
@property(nonatomic,strong)IBOutlet UILabel *website_label;
@property(nonatomic,strong)IBOutlet UILabel *other_label;
@property(nonatomic,strong)IBOutlet UILabel *eventDescription_label;
@property(nonatomic,strong)IBOutlet UILabel *description_label;
@property(nonatomic,strong)IBOutlet UILabel *othertechnologies_label;
@property(nonatomic,strong)IBOutlet UILabel *otherservicesneeded_label;
@property(nonatomic,strong)IBOutlet UILabel *otherServices_label;
@property(nonatomic,strong)IBOutlet UILabel *captioning_type_label;
@property(nonatomic,strong)IBOutlet UILabel *viewingType_label;
@property(nonatomic,strong)IBOutlet UILabel *ofUsers_label;

@end
