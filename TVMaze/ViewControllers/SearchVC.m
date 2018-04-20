//
//  SearchVC.m
//  TVMaze
//
//  Created by admin on 15/04/2018.
//  Copyright © 2018 admin. All rights reserved.
//

//Controllers
#import "SearchVC.h"
#import "DetailsVC.h"
#import "PickShowTypeVC.h"

//Models
#import "Show.h"

#import "NSArray+RandomObject.h"
#import "TableViewCell.h"
#import "NSString_stripHtml.h"

@interface SearchVC () <PickShowTypeVCDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray<Show *> *showsArray;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.tableOfShows.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

//Method that performs the call to fetch shows and movies
- (void)fetchShows
{
    NSString *noSummaryAvailable = @"No Summary available";
    NSString *noRatingAvailable = @"No Rating available";
    NSString *noImageURL = @"http://static.tvmaze.com/images/no-img/no-img-portrait-text.png";
    
    NSString *userSearchQuery = [NSString stringWithFormat:@"http://api.tvmaze.com/search/shows?q=%@", self.searchBar.text];
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
                NSArray *showItemsFromJson = [responseDictionary valueForKey:@"show"];
                self.showsArray = [[NSMutableArray alloc] init];
                for (NSDictionary *item in showItemsFromJson)
                {
                    NSString *parsedSummary = item[@"summary"];
                    
                    NSString *parsedImage = item[@"image"];
                    NSDictionary *image = item[@"image"];
                    
                    NSDictionary *rating = item[@"rating"];
                    NSNumber *parsedRating = rating[@"average"];
                    
                    Show *show = [[Show alloc]initWithTitle:item[@"name"]
                                                    Summary:([parsedSummary isEqual:[NSNull null]] ? noSummaryAvailable : parsedSummary)
                                                      Image:([parsedImage isEqual:[NSNull null]] ? noImageURL : image[@"medium"])
                                                     Rating:([rating[@"average"] isEqual:[NSNull null]] ? noRatingAvailable : ([NSString stringWithFormat:@"%.1f", [parsedRating floatValue]]))];
                    
                    [self.showsArray addObject:show];
                }
            }
        }
        else{
            NSLog(@"ERROR %@", error);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableOfShows reloadData];
        });
    }];
    
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.titleLabel.text = [@"Title: " stringByAppendingString:self.showsArray [indexPath.row].title];
    
    cell.summaryLabel.text = [@"Rating: " stringByAppendingString:self.showsArray [indexPath.row].averageRating];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [self.showsArray[indexPath.row] image]]];
    cell.image.image = [UIImage imageWithData: imageData];
    
    return cell;
}

//Customize cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath* )indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailsVC *dest = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsVC"];
    dest.show = self.showsArray[indexPath.row];
    
    //Call Method to select a random object, based on the category NSArray+RandomObject
    //dest.show = [self.showsArray randomObject];
    [self.navigationController pushViewController:dest animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self fetchShows];
    [searchBar resignFirstResponder];
}

- (IBAction)didClickMe:(id)sender {
    PickShowTypeVC *pickShow = [self.storyboard instantiateViewControllerWithIdentifier:@"pickShow"];
    //set self delegate to PickShowTypeVC delegate
    pickShow.delegate = self;
    [self presentViewController:pickShow
                       animated:YES
                     completion:nil];
}

- (void) pickShowVC:(PickShowTypeVC *)pickShowTypeVC didSelectButton:(UIButton *)whoCLickedMe{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    if(whoCLickedMe.tag == 1){
        [self addAlertViewForShow];
    }
    else if(whoCLickedMe.tag == 2){
        [self addAlertViewForMovie];
    }
}

-(void)addAlertViewForShow {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:@"TV show type was selected."
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              NSLog(@"You pressed OK button");
                                                          }];
    [alert addAction:firstAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)addAlertViewForMovie {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:@"Movie type was selected."
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              NSLog(@"You pressed OK button");
                                                          }];
    [alert addAction:firstAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
