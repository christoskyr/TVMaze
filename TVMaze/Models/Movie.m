//
//  Movie.m
//  TVMaze
//
//  Created by admin on 11/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype) initWithOscarNomination:(NSString *)typeOfOscarNomination
                            MovieSummary:(NSString *)movieSummary
{
    self = [super initWithTitle:self.title
                        Summary:movieSummary
                          Image:self.image
                         Rating:self.averageRating
                           Type:self.mediaType
                        ShowId:self.ShowId
                        GenreId:self.GenreId];
    
    if(self){
        self.typeOfOscarNomination = typeOfOscarNomination;
    }
    
    return self;
}

- (void) getSummary
{
    NSLog(@"This is a Movie summary");
}

@end
