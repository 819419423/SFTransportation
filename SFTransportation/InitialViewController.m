//
//  InitialViewController.m
//  SFTransportation
//
//  Created by Kobe Dai on 5/8/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "InitialViewController.h"
#import "LeftMenuViewController.h"
#import "CaltrainNavigationViewController.h"
#import "SFStopTime.h"
#import "SFStop.h"

@interface InitialViewController ()

@property (nonatomic) LeftMenuViewController                    *lmvc;
@property (nonatomic) CaltrainNavigationViewController          *caltrain;

@end

@implementation InitialViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(showLeftSlidingMenu:)
                                                 name: @"ShowLeftMenu"
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(hideLeftSlidingMenu:)
                                                 name: @"HideLeftMenu"
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(changeTopViewController:)
                                                 name: @"ChangeTopView"
                                               object: nil];
    
    self.lmvc = [self.storyboard instantiateViewControllerWithIdentifier: @"LeftMenu"];
    self.caltrain = [self.storyboard instantiateViewControllerWithIdentifier: @"CaltrainNav"];
    
    self.topViewController = self.caltrain;
    self.underLeftViewController = self.lmvc;
    self.anchorRightRevealAmount = 260.f;
    [self.view addGestureRecognizer: self.panGesture];
    
    [self loadCaltrainData];
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"stops" ofType: @"txt"];
//    
//    NSError *error;
//    NSString *content = [NSString stringWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: &error];
//    
//    if (error == nil) {
//        NSArray *contentArray = [content componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
//        for (int i = 1; i < contentArray.count-1; i++) {
//            NSString *eachLine = contentArray[i];
//            NSLog(@"eachline: %@", eachLine);
//            NSArray *dataArray = [eachLine componentsSeparatedByString: @","];
//            NSLog(@"name: %@", dataArray[2]);
//        }
//    }
}

- (void)changeTopViewController: (NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    NSString *viewControllerName = [dict objectForKey: @"ViewController"];
    
    if ([viewControllerName isEqualToString: @"Caltrain"]) {
        self.topViewController = self.caltrain;
    }
    
    [self resetTopViewWithAnimations:nil onComplete:nil];
}

- (void)showLeftSlidingMenu: (NSNotification *)notification
{
    [self anchorTopViewTo: ECRight];
}

- (void)hideLeftSlidingMenu: (NSNotification *)notification
{
    [self anchorTopViewTo: ECLeft];
}

- (void)loadCaltrainData {
    
    [AppDelegate sharedDelegate].hud = [MBProgressHUD showHUDAddedTo:self.caltrain.view animated:YES];
    
    // Caltrain Stops
    if ([self isEmptyWithEntityName: @"SFStop"]) {
        
        NSString *content = [self getFileContentsWithFileName: @"stops"];
        NSLog(@"content: %@", content);
        if (content != nil) {
            NSArray *contentArray = [content componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
            
            for (int i = 1; i < contentArray.count-1; i++) {
                NSLog(@"flag");
                NSString *eachLine = contentArray[i];
                NSArray *dataArray = [eachLine componentsSeparatedByString: @","];
                
                SFStop *newStop = [NSEntityDescription insertNewObjectForEntityForName: @"SFStop" inManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
                
                newStop.stop_id = dataArray[0];
                newStop.stop_code = dataArray[1];
                newStop.stop_name = [dataArray[2] stringByReplacingOccurrencesOfString: @"\"" withString: @""];
                newStop.stop_lat = [NSNumber numberWithFloat: [dataArray[4] floatValue]];
                newStop.stop_lon = [NSNumber numberWithFloat: [dataArray[5] floatValue]];
                newStop.platform_code = dataArray[10];
                
                [[AppDelegate sharedDelegate].managedObjectContext save: nil];
            }
        }

    }
    
    [MBProgressHUD hideHUDForView:self.caltrain.view animated:YES];
}

- (BOOL)isEmptyWithEntityName: (NSString *)entityName {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: entityName];
    NSEntityDescription *entity = [NSEntityDescription entityForName: entityName inManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
    [request setEntity: entity];
    NSArray *stopResults = [[AppDelegate sharedDelegate].managedObjectContext executeFetchRequest: request error: nil];
    if (stopResults.count == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)getFileContentsWithFileName: (NSString *)fileName {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource: fileName ofType: @"txt"];
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: &error];
    
    if (error == nil) {
        return content;
    } else {
        return nil;
    }
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
