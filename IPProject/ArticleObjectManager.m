//
//  MNSArticleMapper.m
//  MusicNewsShuffler
//
//  Created by Nick Nikolov on 21/02/2013.
//  Copyright (c) 2013 Nick Nikolov. All rights reserved.
//

#import "ArticleObjectManager.h"
#import <RestKit/RestKit.h>
#import "DataModel.h"
#import "Movie.h"


@interface ArticleObjectManager ()
@end

@implementation ArticleObjectManager

+ (RKObjectManager *)createNewManager
{
    
    static RKObjectManager *__sharedObjectManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RKEntityMapping *articleMapping = [self mapArticle];
        RKManagedObjectStore *managedObjectStore = [[DataModel sharedDataModel] objectStore];
        __sharedObjectManager = [RKObjectManager managerWithBaseURL:
                                 [NSURL URLWithString:@"http://mysterious-plateau-8544.herokuapp.com"]];
        __sharedObjectManager.managedObjectStore = managedObjectStore;
        [__sharedObjectManager addResponseDescriptorsFromArray: @[
                    [self responseDescriptorWithMapping:articleMapping andPathPattern:@"/movies.json"]]];
    });
    
    return __sharedObjectManager;    

}

+ (RKEntityMapping *)mapArticle
{
    RKEntityMapping *articleMapping = [RKEntityMapping
                                       mappingForEntityForName:@"Movie"
                                       inManagedObjectStore:[[DataModel sharedDataModel] objectStore]];
    
    [articleMapping addAttributeMappingsFromDictionary:@{
     @"id"  :   @"movieID",
     @"created_at" : @"createdAt",
     @"updated_at" : @"updatedAt",
     @"description" : @"movieDescription",
     }];
    [articleMapping addAttributeMappingsFromArray:@[@"name", @"genre", @"year"]];
    
    articleMapping.identificationAttributes = @[@"movieID"];
    
    return articleMapping;
}


+ (RKResponseDescriptor *)responseDescriptorWithMapping:(RKEntityMapping *)mapping andPathPattern:(NSString *)pathPattern
{
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor
                                                responseDescriptorWithMapping:mapping
                                                pathPattern:pathPattern
                                                keyPath:nil
                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return responseDescriptor;
}



@end
