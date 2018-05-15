//
//  TvSeries.m
//  TVMaze
//
//  Created by admin on 11/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import "TvSeries.h"

@implementation TvSeries

- (instancetype) initWithNumberOfSeasons:(NSNumber *)numberOfSeasons
                            EpisodeTitle:(NSString *)episodeTitle
                           SeriesSummary:(NSString *)seriesSummary
{
    self = [super initWithTitle:self.title
                         Summary: seriesSummary
                           Image:self.image
                          Rating:self.averageRating
                            Type:self.mediaType
                          ShowId:self.ShowId
                        GenreId:self.GenreId];
    
    if(self){
        self.numberOfSeasons = numberOfSeasons;
        self.episodeTitle = episodeTitle;
    }
    
    return self;
}

- (void) getSummary
{
    NSLog(@"This is a TV Series summary");
}

@end
