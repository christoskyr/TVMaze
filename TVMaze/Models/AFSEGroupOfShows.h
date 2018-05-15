//
//  AFSEGroupOfShows.h
//  TVMaze
//
//  Created by admin on 01/05/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFSEGenreModel.h"
#import "Show.h"

@interface AFSEGroupOfShows : NSObject

@property (strong, nonatomic) AFSEGenreModel * genreModel;
@property (strong, nonatomic) NSMutableArray<Show *> *groupShowsArray;

- (instancetype)initWithGenreModel:(AFSEGenreModel *) genreModel
                  WithGroupOfShows:(NSMutableArray<Show *> *) groupShowsArray;

- (AFSEGenreModel *)getAFSEGenreModel;

- (NSMutableArray<Show *>*)getGroupShowsArray;

@end
