//
//  MoreInfoViewController.m
//  IPProject
//
//  Created by Nick Nikolov on 21/02/2013.
//  Copyright (c) 2013 Nick Nikolov. All rights reserved.
//

#import "MoreInfoViewController.h"


@interface MoreInfoViewController ()
@property NSString* text;
@property NSString* name;
@end

@implementation MoreInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"text: %@", self.textView.text);
    self.textView.text = self.text;
    self.movieName.text = self.name;

}

- (void)setMovieObject:(Movie*)newMovie
{
   // _movie = newMovie;
        
    self.text = newMovie.movieDescription;
    self.name = newMovie.name;
    
}

@end
