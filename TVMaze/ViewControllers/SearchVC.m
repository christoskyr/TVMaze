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
#import "TvSeries.h"
#import "Movie.h"
#import "AFSEGenreModel.h"
#import "AFSEGroupOfShows.h"

#import "NSArray+RandomObject.h"
#import "AFSECustomMovieTableViewCell.h"
#import "AFSECustomTvSeriesTableViewCell.h"
#import "NSString_stripHtml.h"

#define API_KEY @"6b2e856adafcc7be98bdf0d8b076851c"
#define GENRE_URL_MOVIE @"https://api.themoviedb.org/3/genre/movie/list?api_key=%@"
#define GENRE_URL_TV @"https://api.themoviedb.org/3/genre/tv/list?api_key=%@"

enum {
    TVSeries,
    Movies
} Mediatype;

@interface SearchVC () <PickShowTypeVCDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray<Show *> *showsArray;
@property (strong, nonatomic) NSMutableArray<TvSeries *> *tvSeriesArray;
@property (strong, nonatomic) NSMutableArray<Movie *> *moviesArray;
@property (strong, nonatomic) NSMutableArray<NSString *> *mediaTypesArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewConstraint;
@property (strong, nonatomic) NSMutableArray<AFSEGenreModel *> *genresArray;
@property (strong, nonatomic) NSMutableArray<AFSEGroupOfShows *> *groupShows;
@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableOfShows.rowHeight = 140;
//    self.tableOfShows.estimatedRowHeight = 160;
    
    [self fetchGenres:GENRE_URL_MOVIE];
    [self fetchGenres:GENRE_URL_TV];

    self.searchBar.delegate = self;
    self.tableOfShows.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

//Method that performs the call to fetch genres for movies and tv
- (void)fetchGenres:(NSString *) URL
{
    self.genresArray = [[NSMutableArray alloc] init];
    NSString *userSearchQuery = [NSString stringWithFormat:URL, API_KEY];
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

- (void)removeDuplicates:(NSMutableArray<AFSEGenreModel *> *)array
{
    // Delete duplicates
    for (int i=0; i < [array count]; i++ ) {
        for (int j=(i+1); j < [array count]; j++) {
            if ([[array objectAtIndex:i]._id isEqualToNumber:[array objectAtIndex:j]._id]) {
                [array removeObjectAtIndex:j];
                j--;
            }
        }
    }
    
}

//Method that performs the call to fetch shows and movies
- (void)fetchShows
{
    [self removeDuplicates:self.genresArray];
    NSString *userSearchQuery = [NSString stringWithFormat:@"https://api.themoviedb.org/3/search/multi?api_key=%@&query=%@", API_KEY, self.searchBar.text];
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
                NSString *total_results = responseDictionary[@"total_results"];
                if(total_results.intValue == 0){
                    [ self addAlertViewWithTitle:@"Alert"
                                WithMessage:@"No results available for this search"
                                WithStyle:UIAlertControllerStyleActionSheet];
                }
                NSArray *showItemsFromJson = [responseDictionary valueForKey:@"results"];
                self.showsArray = [[NSMutableArray alloc] init];
                self.tvSeriesArray = [[NSMutableArray alloc] init];
                self.moviesArray = [[NSMutableArray alloc] init];
                self.mediaTypesArray = [NSMutableArray arrayWithObjects:
                                        @"TV Series", @"Movies", nil];
                
                for (NSDictionary *item in showItemsFromJson)
                {
                    NSString *parsedSummary = item[@"overview"];
                    NSString *parsedImage = item[@"poster_path"];
                    NSNumber *parsedRating = item[@"vote_average"];
                    NSString *parsedMediaType = item[@"media_type"];
                    NSNumber *parsedId = item[@"id"];
                    NSArray<NSNumber *> *genreIds = item[@"genre_ids"];
                    NSNumber * parsedGenreId;
                    for(int i=0; i<[genreIds count]; i++){
                        parsedGenreId = [genreIds objectAtIndex:0];
                    }
                    
                    NSString *parsedTitle;
                    TvSeries *tvSeries;
                    Movie *movies;
                    
                    if([parsedMediaType isEqualToString:@"tv"])
                    {
                        parsedTitle = item[@"original_name"];
                        parsedMediaType = @"TV Series";
                        tvSeries = [[TvSeries alloc] initWithTitle:parsedTitle
                                                                    Summary:parsedSummary
                                                                    Image:parsedImage
                                                                    Rating:[NSString stringWithFormat:@"%.1f", [parsedRating floatValue]]
                                                                    Type:parsedMediaType
                                                                    ShowId:parsedId
                                                                    GenreId:parsedGenreId];
                        [self.showsArray addObject:tvSeries];
                        [self.tvSeriesArray addObject:tvSeries];
                    }
                    else if([parsedMediaType isEqualToString:@"movie"])
                    {
                        parsedTitle = item[@"original_title"];
                        parsedMediaType = @"Movie";
                        movies = [[Movie alloc] initWithTitle:parsedTitle
                                                      Summary:parsedSummary
                                                        Image:parsedImage
                                                       Rating:[NSString stringWithFormat:@"%.1f", [parsedRating floatValue]]
                                                         Type:parsedMediaType
                                                        ShowId:parsedId
                                                        GenreId:parsedGenreId];
                        [self.showsArray addObject:movies];
                        [self.moviesArray addObject:movies];
                    }
                }
                
                [self createGroupsBasedOnGenre:self.showsArray
                                              :self.genresArray];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFSECustomMovieTableViewCell *movieCell;
    AFSECustomTvSeriesTableViewCell *tvSeriesCell;
    
    if([[[[self.groupShows objectAtIndex:indexPath.section] getGroupShowsArray] objectAtIndex:indexPath.row].mediaType isEqualToString:@"TV Series"]){
        tvSeriesCell = (AFSECustomTvSeriesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AFSECustomTvSeriesTableViewCell"];
        if(!tvSeriesCell){
            [tableView registerNib:[UINib nibWithNibName:@"AFSECustomTvSeriesTableViewCell" bundle:nil] forCellReuseIdentifier:@"AFSECustomTvSeriesTableViewCell"];
            tvSeriesCell = [tableView dequeueReusableCellWithIdentifier:@"AFSECustomTvSeriesTableViewCell"];
        }
        return tvSeriesCell;
    }
    else {
        movieCell = (AFSECustomMovieTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AFSECustomMovieTableViewCell"];
        if(!movieCell){
            [tableView registerNib:[UINib nibWithNibName:@"AFSECustomMovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"AFSECustomMovieTableViewCell"];
            movieCell = [tableView dequeueReusableCellWithIdentifier:@"AFSECustomMovieTableViewCell"];
        }
        return movieCell;
    }
//    if([self.showsArray [indexPath.row] isKindOfClass:[Movie class]]){
//        movieCell = (AFSECustomMovieTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AFSECustomMovieTableViewCell"];
//        if(!movieCell){
//            [tableView registerNib:[UINib nibWithNibName:@"AFSECustomMovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"AFSECustomMovieTableViewCell"];
//            movieCell = [tableView dequeueReusableCellWithIdentifier:@"AFSECustomMovieTableViewCell"];
//        }
//        return movieCell;
//    }
//    else{
//        tvSeriesCell = (AFSECustomTvSeriesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AFSECustomTvSeriesTableViewCell"];
//        if(!tvSeriesCell){
//            [tableView registerNib:[UINib nibWithNibName:@"AFSECustomTvSeriesTableViewCell" bundle:nil] forCellReuseIdentifier:@"AFSECustomTvSeriesTableViewCell"];
//            tvSeriesCell = [tableView dequeueReusableCellWithIdentifier:@"AFSECustomTvSeriesTableViewCell"];
//        }
//        return tvSeriesCell;
//    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[AFSECustomMovieTableViewCell class]]){
        ((AFSECustomMovieTableViewCell *)cell).titleLabel.text = [@"Title: " stringByAppendingString:[[[self.groupShows objectAtIndex:indexPath.section] getGroupShowsArray] objectAtIndex:indexPath.row].title];
        ((AFSECustomMovieTableViewCell *)cell).ratingLabel.text = [@"Rating: " stringByAppendingString:[[[self.groupShows objectAtIndex:indexPath.section] getGroupShowsArray] objectAtIndex:indexPath.row].averageRating];
        //cell.typeLabel.text = [@"Media type: " stringByAppendingString:self.showsArray [indexPath.row].mediaType];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[[[self.groupShows objectAtIndex:indexPath.section] getGroupShowsArray] objectAtIndex:indexPath.row] image]]];
        ((AFSECustomMovieTableViewCell *)cell).movieImage.image = [UIImage imageWithData: imageData];
    }
    else if([cell isKindOfClass:[AFSECustomTvSeriesTableViewCell class]]){
        ((AFSECustomTvSeriesTableViewCell *)cell).tvSeriesTitle.text = [@"Title: " stringByAppendingString:[[[self.groupShows objectAtIndex:indexPath.section] getGroupShowsArray] objectAtIndex:indexPath.row].title];
        ((AFSECustomTvSeriesTableViewCell *)cell).tvSeriesRating.text = [@"Rating: " stringByAppendingString:[[[self.groupShows objectAtIndex:indexPath.section] getGroupShowsArray] objectAtIndex:indexPath.row].averageRating];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[[[self.groupShows objectAtIndex:indexPath.section] getGroupShowsArray] objectAtIndex:indexPath.row] image]]];
        ((AFSECustomTvSeriesTableViewCell *)cell).tvSeriesImage.image = [UIImage imageWithData: imageData];
    }
    
}

//Customize cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath* )indexPath
{
    return 140;
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

- (void)createGroupsBasedOnGenre:(NSMutableArray<Show *>*)showsArray
                                :(NSMutableArray<AFSEGenreModel *>*)genresArray
{
    self.groupShows = [[NSMutableArray alloc] init];
    AFSEGroupOfShows *groupOfShows;

    for(AFSEGenreModel * item in genresArray){
        for(Show * show in showsArray){
            if([item._id isEqualToNumber:show.GenreId]){
                groupOfShows = [[AFSEGroupOfShows alloc]initWithGenreModel:[self getGenreFromArray:genresArray
                                                                                                  :show.GenreId]
                                                          WithGroupOfShows:[self groupShowsFromSearch:showsArray
                                                                                                     :show.GenreId]];
                [self.groupShows addObject:groupOfShows];
                break;
            }
        }
    }
}

- (NSMutableArray<Show *>*)groupShowsFromSearch:(NSMutableArray<Show *>*)shows
                                               :(NSNumber *)genreId
{
    NSMutableArray<Show *>*newGroupedArray = [[NSMutableArray alloc] init];;
    for(Show * item in shows){
        if([item.GenreId isEqualToNumber:genreId]){
            [newGroupedArray addObject:item];
        }
    }
    return newGroupedArray;
}

- (AFSEGenreModel *)getGenreFromArray:(NSMutableArray<AFSEGenreModel *>*)genreArray
                                   :(NSNumber *)genreId
{
    for(AFSEGenreModel * item in genreArray){
        if([genreId isEqualToNumber:item._id]){
            return item;
        }
    }
    
    return nil;
}

- (IBAction)didClickMe:(id)sender {
    PickShowTypeVC *pickShow = [self.storyboard instantiateViewControllerWithIdentifier:@"pickShow"];
    //set self delegate to PickShowTypeVC delegate
    pickShow.delegate = self;
    [self presentViewController:pickShow
                       animated:YES
                     completion:nil];
}

- (void)pickShowVC:(PickShowTypeVC *)pickShowTypeVC didSelectButton:(UIButton *)whoCLickedMe{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    if(whoCLickedMe.tag == 1){
        [self addAlertViewWithTitle:@"Alert"
                        WithMessage:@"TV show type was selected."
                          WithStyle:UIAlertControllerStyleActionSheet];
    }
    else if(whoCLickedMe.tag == 2){
        [self addAlertViewWithTitle:@"Alert"
                        WithMessage:@"Movie type was selected."
                          WithStyle:UIAlertControllerStyleActionSheet];
    }
}

/************ ALERTS ***********************************/
-(void)addAlertViewWithTitle: (NSString *)alertTitle
                 WithMessage: (NSString *)alertMessage
                   WithStyle: (UIAlertControllerStyle) style
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                   message:alertMessage
                                                            preferredStyle:style];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              NSLog(@"You pressed OK button");
                                                          }];
    [alert addAction:firstAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/************ SECTIONS ******************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupShows.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    return ((AFSEGenreModel *)[[self.groupShows objectAtIndex:section] getAFSEGenreModel]).name;
    return self.groupShows[section].genreModel.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((NSMutableArray<AFSEGroupOfShows *>*)[[self.groupShows objectAtIndex:section] getGroupShowsArray]) count];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.showsArray.count;
//}
@end
