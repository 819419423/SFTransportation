//
//  CaltrainNavigationViewController.m
//  SFTransportation
//
//  Created by Kobe Dai on 5/8/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "CaltrainNavigationViewController.h"

@interface CaltrainNavigationViewController ()

@end

@implementation CaltrainNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.layer.shadowRadius = 6.0f;
    self.view.layer.shadowOpacity = 0.6f;
    self.view.layer.shadowColor = [UIColor greenColor].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
