//
//  AFSENetworkManagerDelegate.h
//  TVMaze
//
//  Created by admin on 08/05/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFSENetworkManagerDelegate <NSObject>

//When making a delegate, it is a good pattern to pass as first argument, the id of who calls you (caller of delegate)
- (void) completeGenresCallWithResponse:(NSMutableArray<AFSEGenreModel *>*)genreArrays;

- (void) completeSearchShowsCallWithResponse:(NSMutableArray<Show *>*)genreArrays;

- (void) completeDetaisShowCallWithResponse;

@end
