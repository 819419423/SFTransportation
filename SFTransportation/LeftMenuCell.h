//
//  LeftMenuCell.h
//  iStudent
//
//  Created by Jing Dai on 9/4/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuCell : UITableViewCell
{
    IBOutlet UILabel                         *label;
    IBOutlet UIImageView                     *imageView;
}

@property (strong, nonatomic) IBOutlet UILabel                   *label;
@property (strong, nonatomic) IBOutlet UIImageView               *imageView;

@end
