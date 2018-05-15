//
//  AFSENetworkManager.h
//  TVMaze
//
//  Created by admin on 04/05/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import <Foundation/Foundation.h>

//Models
#import "AFSEGenreModel.h"
#import "Show.h"

#import "AFSENetworkManagerDelegate.h"

@interface AFSENetworkManager : NSObject

//the delegate property
@property (weak, nonatomic) id<AFSENetworkManagerDelegate> delegate;

- (void)fetchGenresFromUrl:(NSString *)genreUrl
                        ;

@end
