//
//  CaltrainViewController.m
//  SFTransportation
//
//  Created by Kobe Dai on 5/8/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "CaltrainViewController.h"
#import "CaltrainMapCell.h"
#import "CaltrainStationCell.h"
#import "CaltrainSearchCell.h"
#import "SFTransDataProvider.h"
#import "CaltrainStopsViewController.h"

#define __CALTRAIN_MAP_CELL__ 0
#define __CALTRAIN_START_STATION_CELL__ 1
#define __CALTRAIN_STOP_STATION_CELL__ 2
#define __CALTRAIN_SEARCH_CELL__ 3
#define __CALTRAIN_GOHOME_CELL__ 4
#define __CALTRAIN_GOWORK_CELL__ 5

@interface CaltrainViewController ()

@property (nonatomic) SFTransDataProvider *transDataProvider;
@property (nonatomic) NSArray *stopsArray;
@property (nonatomic) CaltrainStopsViewController *caltrainStopsVC;
@property (nonatomic) NSString *currentStart;
@property (nonatomic) NSString *currentStop;

@end

@implementation CaltrainViewController

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
    
    self.currentStart = @"San Francisco";
    self.currentStop = @"San Jose";
    
    self.caltrainStopsVC = [self.storyboard instantiateViewControllerWithIdentifier: @"CaltrainStops"];
    
    self.transDataProvider = [[SFTransDataProvider alloc] init];
    
    [self.transDataProvider loadCaltrainStopsonSuccess:^(NSArray *data) {
        
        if (data != nil) {
            self.stopsArray = data;
        }
        
    } onError:^(NSError *error) {
        
    }];
}

#pragma mark - UITableview data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Map Cell
    if (indexPath.row == __CALTRAIN_MAP_CELL__) {
        
        static NSString *CellIdentifier = @"MapCell";
        CaltrainMapCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
        if (cell == nil) {
            cell = [[CaltrainMapCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        }
        
        return cell;
        
    } else if (indexPath.row == __CALTRAIN_START_STATION_CELL__ || indexPath.row == __CALTRAIN_STOP_STATION_CELL__) {
        
        static NSString *CellIdentifier = @"StationCell";
        
        CaltrainStationCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
        if (cell == nil) {
            cell = [[CaltrainStationCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        }
        
        if (indexPath.row == __CALTRAIN_START_STATION_CELL__) {
            cell.stationLabel.text = _currentStart;
        } else {
            cell.stationLabel.text = _currentStop;
        }
        
        cell.logo.image = [UIImage imageNamed: @"caltrain_logo"];
        cell.stationView.layer.cornerRadius = 4.0f;
        
        
        return cell;
        
    } else if (indexPath.row == __CALTRAIN_SEARCH_CELL__) {
        
        static NSString *CellIdentifier = @"SearchCell";
        
        CaltrainSearchCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
        if (cell == nil) {
            cell = [[CaltrainSearchCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        }
        
        cell.searchView.layer.cornerRadius = 4.0f;
        
        return cell;
        
    } else if (indexPath.row == __CALTRAIN_GOHOME_CELL__) {
        
        static NSString *CellIdentifier = @"StationCell";
        
        CaltrainStationCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
        if (cell == nil) {
            cell = [[CaltrainStationCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        }
        
        cell.stationLabel.text = @"Go Home";
        
        cell.logo.image = [UIImage imageNamed: @"home_logo"];
        cell.stationView.layer.cornerRadius = 4.0f;
        
        return cell;
        
    } else if (indexPath.row == __CALTRAIN_GOWORK_CELL__) {
        
        static NSString *CellIdentifier = @"StationCell";
        
        CaltrainStationCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
        if (cell == nil) {
            cell = [[CaltrainStationCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        }
        
        cell.stationLabel.text = @"Go Office";
        
        cell.logo.image = [UIImage imageNamed: @"work_logo"];
        cell.stationView.layer.cornerRadius = 4.0f;
        
        return cell;
    }
    
    
    else {
        
        return nil;
    }
}

#pragma mark - UITableView delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == __CALTRAIN_MAP_CELL__) {
        return 150.0f;
    } else if (indexPath.row == __CALTRAIN_START_STATION_CELL__ || indexPath.row == __CALTRAIN_STOP_STATION_CELL__ || indexPath.row == __CALTRAIN_GOHOME_CELL__ || indexPath.row == __CALTRAIN_GOWORK_CELL__) {
        return 44.0f;
    } else if (indexPath.row == __CALTRAIN_SEARCH_CELL__) {
        return 80.0f;
    }
    
    else {
        return 44.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == __CALTRAIN_MAP_CELL__) {
        
        
        
    } else if (indexPath.row == __CALTRAIN_START_STATION_CELL__) {
        
        CaltrainStationCell *cell = (CaltrainStationCell *)[tableView cellForRowAtIndexPath: indexPath];
        cell.stationView.backgroundColor = [UIColor colorWithRed:0.615 green:0.493 blue:0.941 alpha:1.000];
        
        _caltrainStopsVC.navItem.title = @"Start Station";
        _caltrainStopsVC.caltrains = _stopsArray;
        [self presentViewController: _caltrainStopsVC animated: YES completion: ^{
            cell.stationView.backgroundColor = [UIColor whiteColor];
        }];
        
    } else if (indexPath.row == __CALTRAIN_STOP_STATION_CELL__) {
        
        CaltrainStationCell *cell = (CaltrainStationCell *)[tableView cellForRowAtIndexPath: indexPath];
        cell.stationView.backgroundColor = [UIColor colorWithRed:0.615 green:0.493 blue:0.941 alpha:1.000];
        
        _caltrainStopsVC.navItem.title = @"Stop Station";
        _caltrainStopsVC.caltrains = _stopsArray;
        [self presentViewController: _caltrainStopsVC animated: YES completion: ^{
            cell.stationView.backgroundColor = [UIColor whiteColor];
        }];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openMenu:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"ShowLeftMenu" object: nil userInfo: nil];
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
