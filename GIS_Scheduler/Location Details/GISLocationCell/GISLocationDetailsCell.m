//
//  GISLocationDetailsCell.m
//  GIS_Scheduler
//
//  Created by Anand on 17/07/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISLocationDetailsCell.h"
#import "GISFonts.h"
#import "GISConstants.h"

@implementation GISLocationDetailsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [_locationDetailsOffcampus_label setFont:[GISFonts large]];
    [_buildingName_label setFont:[GISFonts normal]];
    [_roomName_label setFont:[GISFonts normal]];
    [_roomNo_label setFont:[GISFonts normal]];
    [_other_label setFont:[GISFonts normal]];
    [_socialProtocol_label setFont:[GISFonts normal]];
    [_metroNearby_label setFont:[GISFonts normal]];
    [_parking_label setFont:[GISFonts normal]];
    [_garage_label setFont:[GISFonts normal]];
    [_mattered_label setFont:[GISFonts normal]];
    [_street_label setFont:[GISFonts normal]];
    [_unknown_label setFont:[GISFonts normal]];
    [_generalLocation_label setFont:[GISFonts normal]];
    
    [_locationDetailsOffcampus_label setText:NSLocalizedStringFromTable(@"event_name", TABLE, nil)];
    [_buildingName_label setText:NSLocalizedStringFromTable(@"event_type", TABLE, nil)];
    [_roomName_label setText:NSLocalizedStringFromTable(@"on_going", TABLE, nil)];
    [_roomNo_label setText:NSLocalizedStringFromTable(@"open_toPublic", TABLE, nil)];
    [_other_label setText:NSLocalizedStringFromTable(@"dress_Code", TABLE, nil)];
    [_socialProtocol_label setText:NSLocalizedStringFromTable(@"recorede_braoadcast", TABLE, nil)];
    [_metroNearby_label setText:NSLocalizedStringFromTable(@"no", TABLE, nil)];
    [_parking_label setText:NSLocalizedStringFromTable(@"yes", TABLE, nil)];
    [_garage_label setText:NSLocalizedStringFromTable(@"yes", TABLE, nil)];
    [_mattered_label setText:NSLocalizedStringFromTable(@"course_id", TABLE, nil)];
    [_street_label setText:NSLocalizedStringFromTable(@"no", TABLE, nil)];
    [_unknown_label setText:NSLocalizedStringFromTable(@"yes", TABLE, nil)];
    [_generalLocation_label setText:NSLocalizedStringFromTable(@"fm_system", TABLE, nil)];
    

}

@end
