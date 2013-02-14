//
//  Movie.h
//  IPProject
//
//  Created by Nick Nikolov on 13/02/2013.
//  Copyright (c) 2013 Nick Nikolov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property NSString *createdAt;
@property NSString *description;
@property NSString *genre;
@property NSInteger *movieID;
@property NSString *name;
@property NSString *updatedAt;
@property NSInteger *year;

+ (Movie*)createMovieWithDictionary:(NSDictionary*) dict;

@end
