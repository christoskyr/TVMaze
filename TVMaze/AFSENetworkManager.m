//
//  AFSENetworkManager.m
//  TVMaze
//
//  Created by admin on 04/05/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import "AFSENetworkManager.h"

#define API_KEY @"6b2e856adafcc7be98bdf0d8b076851c"

@implementation AFSENetworkManager

- (void)fetchGenresFromUrl:(NSString *)genreUrl
{
    self.genresArray = [[NSMutableArray alloc] init];
    NSString *userSearchQuery = [NSString stringWithFormat:genreUrl, API_KEY];
    NSURL *searchURL = [NSURL URLWithString:userSearchQuery];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:searchURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            if([responseDictionary count] == 0)
            {
                NSLog(@"NO KEY");
            }
            else{
                NSArray *genresItemsFromJson = [responseDictionary valueForKey:@"genres"];
                
                for (NSDictionary *item in genresItemsFromJson)
                {
                    NSNumber *parsedId = item[@"id"];
                    NSString *parsedName = item[@"name"];
                    AFSEGenreModel *genreModel = [[AFSEGenreModel alloc] initWithId:parsedId
                                                                               Name:parsedName];
                    
                    [self.genresArray addObject:genreModel];
                }
            }
            
        }
        else{
            NSLog(@"ERROR %@", error);
        }
    }];
    
    [dataTask resume];
}

@end
