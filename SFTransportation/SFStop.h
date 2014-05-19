//
//  SFStop.h
//  SFTransportation
//
//  Created by Kobe Dai on 5/12/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SFStop : NSManagedObject

@property (nonatomic, retain) NSString * stop_code;
@property (nonatomic, retain) NSString * stop_id;
@property (nonatomic, retain) NSString * stop_name;
@property (nonatomic, retain) NSNumber * stop_lat;
@property (nonatomic, retain) NSNumber * stop_lon;
@property (nonatomic, retain) NSString * platform_code;

@end
