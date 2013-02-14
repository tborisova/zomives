//
//  Movie.m
//  IPProject
//
//  Created by Nick Nikolov on 13/02/2013.
//  Copyright (c) 2013 Nick Nikolov. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (Movie *)createMovieWithDictionary:(NSDictionary *)dict
{
    Movie *movie = [[Movie alloc]init];
    
    movie.createdAt = [dict objectForKey:@"created_at"];
    movie.description = [dict objectForKey:@"description"];
    movie.genre = [dict objectForKey:@"genre"];
    movie.movieID = [[dict objectForKey:@"id"] integerValue];
    movie.name = [dict objectForKey:@"name"];
    movie.updatedAt = [dict objectForKey:@"updated_at"];
    movie.year = [[dict objectForKey:@"year"] integerValue];
    return movie;

}



@end
