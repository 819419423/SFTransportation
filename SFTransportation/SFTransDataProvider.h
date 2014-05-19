//
//  SFTransDataProvider.h
//  SFTransportation
//
//  Created by Kobe Dai on 5/12/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^loadSuccess)(NSArray *data);
typedef void (^loadFailed)(NSError *error);

@interface SFTransDataProvider : NSObject

+ (id)sharedInstance;

- (void)loadCaltrainStopsonSuccess: (loadSuccess)onSuccess
                           onError: (loadFailed)onError;

@end
