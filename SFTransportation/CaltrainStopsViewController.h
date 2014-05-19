//
//  CaltrainStopsViewController.h
//  SFTransportation
//
//  Created by Kobe Dai on 5/9/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaltrainStopsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic) IBOutlet UITableView *stopsTableView;
@property (nonatomic) NSArray *caltrains;

@end
