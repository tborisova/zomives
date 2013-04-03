//
//  Movie.h
//  IPProject
//
//  Created by Nick Nikolov on 14/03/2013.
//  Copyright (c) 2013 Nick Nikolov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * createdAt;
@property (nonatomic, retain) NSString * movieDescription;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSNumber * movieID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * updatedAt;
@property (nonatomic, retain) NSNumber * year;

@end
