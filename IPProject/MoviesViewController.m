//
//  ViewController.m
//  IPProject
//
//  Created by Nick Nikolov on 13/02/2013.
//  Copyright (c) 2013 Nick Nikolov. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "MoviesViewController.h"
#import "Movie.h"
#import "MoreInfoViewController.h"
#import <RestKit/RestKit.h>
#import "DataModel.h"
#import "SVProgressHUD.h"
#import "ArticleObjectManager.h"




@interface MoviesViewController() <NSFetchedResultsControllerDelegate>
@property NSFetchedResultsController *fetchedResultsController;
@end

@implementation MoviesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Movie"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"year" ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    
    
    RKObjectManager *objectManager = [ArticleObjectManager createNewManager];

    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[objectManager managedObjectStore].mainQueueManagedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
    [self.fetchedResultsController setDelegate:self];
    NSError *error = nil;
    
    BOOL fetchSuccessful = [self.fetchedResultsController performFetch:&error];
    
    if (! fetchSuccessful) {
        [SVProgressHUD showErrorWithStatus:@"Dang! :("];
    }
    
    
    [objectManager getObjectsAtPath:@"/movies.json"
                          parameters:nil
                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         
         NSLog(@"RESULTTTTTTTT: %@", mappingResult.array);
                  
     } failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         NSLog(@"ERROR: %@", error);
         NSLog(@"Response: %@", operation.HTTPRequestOperation.responseString);
         
         
     }];


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"MovieTableCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    Movie* movie = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = movie.name;
    
    return cell;

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"moreInfo"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        
       // NSLog(@"indexpath: %@", indexPath);

      //  Movie *selectedMovie = [Movie createMovieWithDictionary:[self.movies objectAtIndex:indexPath]];
        
//        NSLog(@"%@", selectedMovie.movieDescription);
        [(MoreInfoViewController*)[segue destinationViewController] setMovieObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    }
}

@end
