//
//  TransDataProvider.m
//  SFTransportation
//
//  Created by Kobe Dai on 5/9/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "TransDataProvider.h"
#import "AFHTTPRequestOperationManager.h"
#import "XMLReader.h"

#define __TRANS_BASE_URL__ @"http://services.my511.org/Transit2.0/"
#define __TRANS_TOKEN__ @"b01c8e56-c4af-4e08-8e31-eaabfe950a30"

typedef void (^blockDataRequestSuccess) (NSData *response);

@implementation TransDataProvider

- (void)getRoutesWithAgency:(NSString *)agency
                  onSuccess:(loadSuccess)onSuccess
                    onError:(loadFailed)onError
{
    
}

- (void)getStopsWithAgency:(NSString *)agency
             withRouteCode:(NSString *)routeCode
        withRouteDirection:(NSString *)routeDirection
                 onSuccess:(loadSuccess)onSuccess
                   onError:(loadFailed)onError
{
    NSString *urlString = @"";
    
    if (routeDirection == nil) {
        urlString = [NSString stringWithFormat: @"%@GetStopsForRoute.aspx?token=%@&routeIDF=%@~%@", __TRANS_BASE_URL__, __TRANS_TOKEN__, agency, routeCode];
    } else {
        urlString = [NSString stringWithFormat: @"%@GetStopsForRoute.aspx?token=%@&routeIDF=%@~%@~%@", __TRANS_BASE_URL__, __TRANS_TOKEN__, agency, routeCode, routeDirection];
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [self fetchDataWithURL: urlString
                 onSuccess:^(NSData *response) {
                     
                     // Success
                     NSString *theXML = [[NSString alloc] initWithData: response encoding: NSUTF8StringEncoding];
                     theXML=[theXML stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
                     theXML=[theXML stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>" withString:@""];
                     
                     NSDictionary *dict = [XMLReader dictionaryForXMLString: theXML error: nil];
                     
                     if ([agency isEqualToString: @"CALTRAIN"]) {
                         NSArray *stops = (NSArray *)[self parseDictionary: dict tempDict: nil element: @"Stop"];
                         
                         NSMutableArray *caltrains = [NSMutableArray new];
                         for (NSDictionary *stop in stops) {
                             
                             Caltrain *caltrain = [Caltrain new];
                             caltrain.stationName = [stop objectForKey: @"name"];
                             caltrain.stationCode = [stop objectForKey: @"StopCode"];
                             
                             [caltrains addObject: caltrain];
                         }
                         
                         onSuccess(caltrains);
                     }
                     
                     
                 } onError:^(NSError *error) {
                     
                     // Error
                     NSLog(@"error: %@", error);
                 }];
}

- (void)getNextDepartWithCaltrain:(Caltrain *)caltrain
                        onSuccess:(loadSuccess)onSuccess
                          onError:(loadFailed)onError
{
    NSString *urlString = [NSString stringWithFormat: @"%@GetNextDeparturesByStopCode.aspx?token=%@&stopcode=%@", __TRANS_BASE_URL__, __TRANS_TOKEN__, caltrain.stationCode];
    
    [self fetchDataWithURL: urlString
                 onSuccess:^(NSData *response) {
                     
//                     NSString *theXML = [[NSString alloc] initWithData: response encoding: NSUTF8StringEncoding];
//                     theXML=[theXML stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
//                     theXML=[theXML stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>" withString:@""];
//                     
//                     NSDictionary *dict = [XMLReader dictionaryForXMLString: theXML error: nil];
                     
                 } onError:^(NSError *error) {
                     
                     
                     
                 }];
}

#pragma mark - private methods

- (void)fetchDataWithURL: (NSString *)urlStr
               onSuccess: (blockDataRequestSuccess)onSuccess
                 onError: (loadFailed)onError
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    
    [manager GET: urlStr
      parameters: nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             // call back
             onSuccess(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             // Error
             onError(error);
         }];
}

- (NSObject*)parseDictionary:(NSDictionary*)dict tempDict:(NSDictionary*)tempDict element:(NSString*)element
{
    NSObject *object = nil;
    NSEnumerator *enumerator;
    NSDictionary *currentDict;
    
    if(tempDict)
    {
        enumerator = [tempDict keyEnumerator];
        currentDict = tempDict;
    }
    else
    {
        enumerator = [dict keyEnumerator];
        currentDict = dict;
    }
    
    id key;
    
    while ((key = [enumerator nextObject]))
    {
        if (object==nil) {
            //NSLog(@"key:%@ -- class:%@ -- currentDict:%@",key,[[currentDict objectForKey:key] class],[currentDict objectForKey:key]);
            if ([[currentDict objectForKey:key] isKindOfClass:[NSDictionary class]]) {
                if ([key isEqualToString:element]) {
                    if ([[[currentDict objectForKey:key] allKeys] count] > 1) {
                        object = (NSDictionary*)[currentDict objectForKey:key];
                    }
                    else {
                        object = (NSString*)[[currentDict objectForKey:key] objectForKey:@"text"];
                    }
                    tempDict = nil;
                    break;
                }
                else {
                    object = [self parseDictionary:dict tempDict:[currentDict objectForKey:key] element:element];
                }
            }
            else if ([[currentDict objectForKey:key] isKindOfClass:[NSArray class]]) {
                if ([key isEqualToString:element]) {
                    object = (NSArray*)[currentDict objectForKey:key];
                    tempDict = nil;
                    break;
                }
            }
        }
        else
        {
            break;
        }
    }
    
    return object;
}


@end
