//
//  Movie.h
//  TVMaze
//
//  Created by admin on 11/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

#import "Show.h"

@interface Movie : Show

@property (strong, nonatomic) NSString * typeOfOscarNomination;
@property (strong, nonatomic) NSString *movieSummary;

- (instancetype) initWithOscarNomination:(NSString *) typeOfOscarNomination
                            MovieSummary:(NSString *) movieSummary;

- (void) getSummary;

@end
