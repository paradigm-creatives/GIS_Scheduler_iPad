//
//  GISAttendeesCell.h
//  GIS_Scheduler
//
//  Created by Paradigm on 15/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GISAttendeesTopCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UILabel *expectedNo_Label;
@property(nonatomic,strong)IBOutlet UILabel *genderPreference_Label;
@property(nonatomic,strong)IBOutlet UILabel *preference_Label;

//@property(nonat




@property(nonatomic,strong)IBOutlet UILabel *choose_request_answer_Label;
@property(nonatomic,strong)IBOutlet UILabel *expectedNo_answer_Label;
@property(nonatomic,strong)IBOutlet UILabel *genderPreference_answer_Label;
@property(nonatomic,strong)IBOutlet UILabel *preference_answer_Label;

@property(nonatomic,strong)IBOutlet UILabel *primaryAudience_Label;
@property(nonatomic,strong)IBOutlet UILabel *primaryAudience_answer_Label;
@property(nonatomic,strong)IBOutlet UIButton *primaryAudience_Button;
//omic,strong)IBOutlet UIButton *expectedNo_Button;
@property(nonatomic,strong)IBOutlet UIButton *genderPreference_Button;
@property(nonatomic,strong)IBOutlet UIButton *preference_Button;

@end
