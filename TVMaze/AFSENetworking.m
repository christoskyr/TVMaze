//
//  AFSENetworking.m
//  TVMaze
//
//  Created by admin on 30/04/2018.
//  Copyright © 2018 Advantage FSE. All rights reserved.
//

#import "AFSENetworking.h"

@implementation AFSENetworking : NSObject

//- (void)fetchWithURL:(NSString *) url
//          WithAPIKEY:(NSString *) apiKey
//           WithQuery:(NSString *) query
//           WithTable:()
//{
//    NSString *userSearchQuery;
//
//    if(query==nil){
//        userSearchQuery = [NSString stringWithFormat:url, apiKey];
//    }
//    else{
//        userSearchQuery = [NSString stringWithFormat:[url stringByAppendingString:query], apiKey, query];
//    }
//
//    NSURL *searchURL = [NSURL URLWithString:userSearchQuery];
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:searchURL];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        if (httpResponse.statusCode == 200)
//        {
//            NSError *parseError = nil;
//            NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
//            if([responseDictionary count] == 0)
//            {
//                NSLog(@"NO KEY");
//            }
//            else{
//
//                [parseJSONArrayWithDictionary: responseDictionary];
//                NSArray *movieGenresItemsFromJson = [responseDictionary valueForKey:@"genres"];
//
//                for (NSDictionary *item in movieGenresItemsFromJson)
//                {
//
//                }
//            }
//        }
//        else{
//            NSLog(@"ERROR %@", error);
//        }
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableOfShows reloadData];
//        });
//    }];
//
//    [dataTask resume];
//}
//
//- (NSArray *)parseJSONArrayWithDictionary:(NSMutableDictionary *)dictionary
//{
//    NSArray *array = []
//    return [NSArray
//}

@end
