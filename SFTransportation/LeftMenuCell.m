//
//  LeftMenuCell.m
//  iStudent
//
//  Created by Jing Dai on 9/4/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import "LeftMenuCell.h"

@implementation LeftMenuCell

@synthesize label;
@synthesize imageView;

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
}

@end
