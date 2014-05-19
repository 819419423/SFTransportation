//
//  LeftMenuViewController.m
//  iStudent
//
//  Created by Jing Dai on 9/4/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"

@interface LeftMenuViewController ()

@property (nonatomic) NSMutableArray *transportationArray;
@property (nonatomic) NSIndexPath    *currentSelectedIndexPath;

@end

@implementation LeftMenuViewController

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
    
    self.transportationArray = [[NSMutableArray alloc] initWithObjects: @"Caltrain", @"BART", @"SF-MUNI", @"VTA", @"SamTrans", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [_transportationArray count];
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeftMenuCell";
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil)
    {
        cell = [[LeftMenuCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        cell.label.text = [_transportationArray objectAtIndex: indexPath.row];
        cell.imageView.image = [UIImage imageNamed: [_transportationArray objectAtIndex: indexPath.row]];
    }
    else
    {
        cell.label.text = @"Settings";
        cell.imageView.image = [UIImage imageNamed: @"settings"];
    }
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.162 green:0.173 blue:0.188 alpha:1.000];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"ChangeTopView" object: nil userInfo: [NSDictionary dictionaryWithObject: [_transportationArray objectAtIndex: indexPath.row] forKey: @"ViewController"]];
    }
    
    if (_currentSelectedIndexPath == nil) {
        LeftMenuCell *cell = (LeftMenuCell *)[tableView cellForRowAtIndexPath: indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.298 green:0.811 blue:0.061 alpha:1.000];
        self.currentSelectedIndexPath = indexPath;
    } else {
        LeftMenuCell *cell = (LeftMenuCell *)[tableView cellForRowAtIndexPath: indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.298 green:0.811 blue:0.061 alpha:1.000];
        LeftMenuCell *preSelectedCell = (LeftMenuCell *)[tableView cellForRowAtIndexPath: _currentSelectedIndexPath];
        preSelectedCell.contentView.backgroundColor = [UIColor colorWithRed:0.162 green:0.173 blue:0.188 alpha:1.000];
        self.currentSelectedIndexPath = indexPath;
    }

    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Transportation";
    }
    else
    {
        return @"Configuration";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(17, -1, 200, 24)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName: @"Arial Rounded MT Bold" size: 13.0];
    if (section == 0) {
        label.text = @"Transportation";
    } else {
        label.text = @"Settings";
    }
    [headerView addSubview: label];
    [headerView setBackgroundColor: [UIColor blackColor]];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
