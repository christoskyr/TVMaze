//
//  AFSEGenreModel.m
//  TVMaze
//
//  Created by admin on 30/04/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import "AFSEGenreModel.h"

@implementation AFSEGenreModel

- (instancetype) initWithId:(NSNumber *) _id
                       Name:(NSString *) name
{
    self = [super init];
    
    if(self){
        self._id = _id;
        self.name = name;
    }
    
    return self;
}
@end
