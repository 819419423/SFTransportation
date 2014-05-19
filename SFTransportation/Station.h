//
//  Station.h
//  SFTransportation
//
//  Created by Kobe Dai on 5/10/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject

@property (nonatomic) NSString *stationName;
@property (nonatomic) NSString *stationCode;
@property (nonatomic) NSMutableArray *nextDepatures;    /* an array of NextDepature */

@end
