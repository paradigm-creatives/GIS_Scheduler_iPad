//
//  GITFonts.m
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 15/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISFonts.h"
#import "GISConstants.h"

@implementation GISFonts

+ (UIFont *) boldFontWithSize:(CGFloat) fontSize {
    UIFont *font;
    
    font = [UIFont fontWithName:kFontFamilyBold size:fontSize];
 
    return font;
}

+ (UIFont *) fontWithSize:(CGFloat) fontSize {
	UIFont *font;
    
    font = [UIFont fontWithName:kFontFamilyNormal size:fontSize];
    
    return font;
}

+ (UIFont *) hugeBold {
	return [self boldFontWithSize:26.0];
}

+ (UIFont *) largertextBold {
	return [self boldFontWithSize:20.0];
}


+ (UIFont *) largerBold {
	return [self boldFontWithSize:18.0];
}

+ (UIFont *) largetextBold {
	return [self boldFontWithSize:17.0];
}

+ (UIFont *) largeBold {
	return [self boldFontWithSize:16.0];
}

+ (UIFont *) normaltextBold{
	return [self boldFontWithSize:15.0];
}

+ (UIFont *) normalBold {
	return [self boldFontWithSize:14.0];
}

+ (UIFont *) smalltextBold {
	return [self boldFontWithSize:13.0];
}

+ (UIFont *) smallBold {
	return [self boldFontWithSize:12.0];
}

+ (UIFont *) smallerBold {
	return [self boldFontWithSize:11.0];
}

+ (UIFont *) tinyBold {
	return [self boldFontWithSize:10.0];
}

+ (UIFont *) huge {
	return [self fontWithSize:26.0];
}

+ (UIFont *) hugetext {
	return [self fontWithSize:20.0];
}

+ (UIFont *) larger {
	return [self fontWithSize:18.0];
}

+ (UIFont *) largesize {
	return [self fontWithSize:17.0];
}

+ (UIFont *) large {
	return [self fontWithSize:16.0];
}

+ (UIFont *) normalsize {
	return [self fontWithSize:15.0];
}

+ (UIFont *) normal {
	return [self fontWithSize:14.0];
}

+ (UIFont *) small {
	return [self fontWithSize:12.0];
}

+ (UIFont *) smaller {
	return [self fontWithSize:11.0];
}

+ (UIFont *) tiny {
	return [self fontWithSize:10.0];
}


@end
