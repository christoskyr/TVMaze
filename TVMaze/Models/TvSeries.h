//
//  TvSeries.h
//  TVMaze
//
//  Created by admin on 11/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import "Show.h"

@interface TvSeries : Show

@property (strong, nonatomic) NSNumber * numberOfSeasons;
@property (strong, nonatomic) NSString * episodeTitle;
@property (strong, nonatomic) NSString * seriesSummary;

- (instancetype) initWithNumberOfSeasons:(NSNumber *) numberOfSeasons
                            EpisodeTitle:(NSString *) episodeTitle
                            SeriesSummary:(NSString *) seriesSummary;
                    
- (void) getSummary;

@end
