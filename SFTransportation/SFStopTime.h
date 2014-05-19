//
//  SFStopTime.h
//  SFTransportation
//
//  Created by Kobe Dai on 5/12/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SFStopTime : NSManagedObject

@property (nonatomic, retain) NSString * stop_id;
@property (nonatomic, retain) NSDate * arrival_time;
@property (nonatomic, retain) NSDate * departure_time;
@property (nonatomic, retain) NSString * trip_id;

@end
