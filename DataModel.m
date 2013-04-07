//
//  MNSDataModel.m
//  MusicNewsShuffler
//
//  Created by Nick Nikolov on 16/02/2013.
//  Copyright (c) 2013 Nick Nikolov. All rights reserved.
//

#import "DataModel.h"
#import <CoreData/CoreData.h>


@interface DataModel ()
@end



@implementation DataModel


+ (id)sharedDataModel {
    static DataModel *__sharedDataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedDataModel = [[DataModel alloc] init];
        [__sharedDataModel setup];
    });
    
    return __sharedDataModel;
}

- (NSManagedObjectModel *)managedObjectModel {
    return [NSManagedObjectModel mergedModelFromBundles:nil];
}

- (id)optionsForSqliteStore {
    return @{
             NSInferMappingModelAutomaticallyOption:        @YES,
             NSMigratePersistentStoresAutomaticallyOption:  @YES
             };
}

- (void)setup {
    self.objectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Zamovies.sqlite"];
    
    NSLog(@"Setting up store at %@", path);
    
    [self.objectStore createPersistentStoreCoordinator];
    
    NSError *error;

    
    NSPersistentStore *persistentStore = [self.objectStore addSQLitePersistentStoreAtPath:path
                              fromSeedDatabaseAtPath:nil
                                   withConfiguration:nil
                                             options:[self optionsForSqliteStore]
                                               error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);

    
    [self.objectStore createManagedObjectContexts];

        
}
@end