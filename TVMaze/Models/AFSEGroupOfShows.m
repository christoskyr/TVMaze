//
//  AFSEGroupOfShows.m
//  TVMaze
//
//  Created by admin on 01/05/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import "AFSEGroupOfShows.h"

@implementation AFSEGroupOfShows

- (instancetype)initWithGenreModel:(AFSEGenreModel *) genreModel
                  WithGroupOfShows:(NSMutableArray<Show *> *) groupShowsArray
{
    self = [super init];
    
    if(self){
        self.genreModel = genreModel;
        self.groupShowsArray = groupShowsArray;
    }
    
    return self;
}

- (AFSEGenreModel *)getAFSEGenreModel
{
    return self.genreModel;
}

- (NSMutableArray<Show *>*)getGroupShowsArray
{
    return self.groupShowsArray;
}
@end
