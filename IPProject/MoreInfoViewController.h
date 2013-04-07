//
//  MoreInfoViewController.h
//  IPProject
//
//  Created by Nick Nikolov on 21/02/2013.
//  Copyright (c) 2013 Nick Nikolov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
@interface MoreInfoViewController : UIViewController

@property Movie *movie;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *movieName;

- (void)setMovieObject:(Movie*)newMovie;


@end
