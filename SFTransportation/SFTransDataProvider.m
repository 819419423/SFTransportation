//
//  SFTransDataProvider.m
//  SFTransportation
//
//  Created by Kobe Dai on 5/12/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "SFTransDataProvider.h"
#import "SFStop.h"
#import "SFStopTime.h"

@implementation SFTransDataProvider

+ (id)sharedInstance {
    
    static SFTransDataProvider *provider = nil;
    
    @synchronized(self) {
        if (provider == nil) {
            provider = [[SFTransDataProvider alloc] init];
        }
    }
    
    return provider;
}

- (void)loadCaltrainStopsonSuccess:(loadSuccess)onSuccess
                           onError:(loadFailed)onError
{
    NSFetchedResultsController *stopsFRC = [self getFRCWithEntityName: @"SFStop" withKey: @"_pk"];
    [stopsFRC performFetch: nil];
    
    NSArray *results = stopsFRC.fetchedObjects;
    
    onSuccess(results);
}

#pragma mark - private methods

- (NSFetchedResultsController *)getFRCWithEntityName: (NSString *)entityName
                                             withKey: (NSString *)key
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: entityName];
    NSArray *sortDescriptors = [NSArray arrayWithObjects: [NSSortDescriptor sortDescriptorWithKey: key ascending: YES selector: @selector(compare:)], nil];
    request.sortDescriptors = sortDescriptors;
    
    
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                          managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                            sectionNameKeyPath: nil
                                                                                     cacheName: nil];
     
    return frc;
}

@end
