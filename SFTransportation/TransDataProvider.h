//
//  TransDataProvider.h
//  SFTransportation
//
//  Created by Kobe Dai on 5/9/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Caltrain.h"

typedef void (^loadSuccess)(NSMutableArray *data);
typedef void (^loadFailed)(NSError *error);

@interface TransDataProvider : NSObject

- (void)getRoutesWithAgency: (NSString *)agency
                  onSuccess: (loadSuccess)onSuccess
                    onError: (loadFailed)onError;

- (void)getStopsWithAgency: (NSString *)agency
             withRouteCode: (NSString *)routeCode
        withRouteDirection: (NSString *)routeDirection
                 onSuccess: (loadSuccess)onSuccess
                   onError: (loadFailed)onError;

- (void)getNextDepartWithCaltrain:(Caltrain *)caltrain
                        onSuccess: (loadSuccess)onSuccess
                          onError: (loadFailed)onError;

@end
