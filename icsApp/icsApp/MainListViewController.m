//
//  MainListViewController.m
//  icsApp
//
//  Created by Jobelle Vallega on 6/8/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import "MainListViewController.h"
#import "MainListTableViewCell.h"
#import "DetailViewController.h"

@interface MainListViewController (){
    
    NSMutableArray *storiesArray;
    
   
    ArticleModel *toPassObj;
    NSString *toPassImageUrl;
    
    storyType currentType;
    NSInteger articleCount;
    NSInteger otherArrayCount;
   
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)segmentValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)segmentPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation MainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    otherArrayCount = _PER_PAGE;
    storiesArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    currentType = story_featured;
    [self reloadNewsFromPage:@"1" isSearch:NO];
   
   
}

-(void)reloadNewsFromPage:(NSString *)pageFrom isSearch:(BOOL)isSearch{
    
    [self.view makeToastActivity];
    if ( isSearch) {
        currentType = currentType;
        [self.tableView reloadData];
        [self.view hideToastActivity];
    }
    else{
        [[MyRequestHelper sharedInstance] getFeedsFromPage:pageFrom forStoryType:currentType withCompletion:^{
           
            [self.view hideToastActivity];
            
            [storiesArray removeAllObjects];
            [[DateHelper sharedInstance] getNewsForType:currentType withCompletion:^(NSArray *stories) {
                storiesArray = [stories mutableCopy];
                [self.tableView reloadData];
            }];

            
        } orError:^(NSString *error) {
            [self.view hideToastActivity];
        }];
       
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return storiesArray.count + 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.row < storiesArray.count) {
        return 96.0;
    }
    else{
        return 50.0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < storiesArray.count) {
        
        NSString *cellIDentifier = @"cell";
        MainListTableViewCell *cell = (MainListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIDentifier forIndexPath:indexPath];
        ArticleModel *thisObj =  [storiesArray  objectAtIndex:indexPath.row];
        NSLog(@"Image url in each cell %@",  thisObj.imageURL);
      
        [cell.dImage sd_setImageWithURL:[NSURL URLWithString:thisObj.imageURL] placeholderImage:[UIImage imageNamed:@"placeHolderSmall.png"]];
        cell.dTitle.text = thisObj.headline;
        cell.dTeaser.text = thisObj.teaser;
        return cell;
    }
    else{
        NSString *cellIDentifier = @"cell2";
        LoadMoreTableViewCell *cell = (LoadMoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIDentifier forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < storiesArray.count) {
        ArticleModel *thisObj = [storiesArray objectAtIndex:indexPath.row];
        toPassObj = thisObj;
        toPassImageUrl = thisObj.imageURL;
        [self performSegueWithIdentifier:@"toDetail" sender:self];
    }
    
}
-(void)didPressLoadMoreFromCell:(UITableViewCell *)thiscell{
    NSLog(@"I am pressed");
    NSUInteger dividend  = (storiesArray.count / _PER_PAGE) + 1;
    NSLog(@"Dividend %lu", (unsigned long)dividend);
    NSString *nextPage = [NSString stringWithFormat:@"%lu", dividend ];
    [self reloadNewsFromPage:nextPage isSearch:NO];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDetail"]) {
        DetailViewController *dv = segue.destinationViewController;
        dv.passedObj = toPassObj;
        dv.passedImageUrl = toPassImageUrl;
        dv.type = currentType;
    }
}
- (IBAction)segmentPressed:(id)sender {
   
}
- (IBAction)segmentValueChanged:(id)sender {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        NSLog(@"Selected Featured");
        if (currentType != story_featured) {
            
            currentType = story_featured;
            NSUInteger thisTypeSize = [[DateHelper sharedInstance] getNewsSizeForType:currentType];
            NSUInteger dividend = (thisTypeSize /_PER_PAGE) + 1;
            NSString *nextPage = [NSString stringWithFormat:@"%lu", dividend ];
            [self reloadNewsFromPage:nextPage isSearch:NO];
        }
    }
    else if (self.segmentControl.selectedSegmentIndex == 1) {
        NSLog(@"Selected Latest");
        if (currentType != story_latest) {
            
            currentType = story_latest;
            NSUInteger thisTypeSize = [[DateHelper sharedInstance] getNewsSizeForType:currentType];
            NSUInteger dividend = (thisTypeSize /_PER_PAGE) + 1;
            NSString *nextPage = [NSString stringWithFormat:@"%lu", dividend ];
            [self reloadNewsFromPage:nextPage isSearch:NO];

            
            
        }
    }
    else if (self.segmentControl.selectedSegmentIndex == 2) {
        NSLog(@"Selected Arguments");
        [self presentActionSheetWithOptionsHasLetter:YES orHasOurView:YES orHasTheirView:YES];
    }


}
#pragma mark - SearchBar -
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    if (searchText.length == 0) {
        [self reloadNewsFromPage:@"1" isSearch:NO];
        [self resignFirstResponder];
        [self.view endEditing:YES];
    }
    else{
        NSLog(@"Searching....");
        
        [storiesArray removeAllObjects];
        storiesArray =  [[[DateHelper sharedInstance] getNewsSearch:searchText] mutableCopy];
        [self reloadNewsFromPage:@"0" isSearch:YES];
    }
    
    
    
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self reloadNewsFromPage:@"1" isSearch:NO];
    [self resignFirstResponder];
    [self.view endEditing:YES];
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [self resignFirstResponder];
    return YES;
}
#define _LETTER_TITLE        @"Letter to Editor"
#define _OUR_VIEW_TITLE      @"Our View"
#define _THEIR_VIEW_TITLE    @"Their View"
-(void)presentActionSheetWithOptionsHasLetter:(BOOL)hasLetter orHasOurView:(BOOL)hasOurView orHasTheirView:(BOOL)hasTheirView{
    
    UIActionSheet *shett = [[UIActionSheet alloc] initWithTitle:@"Arguments" delegate:self cancelButtonTitle:@"Dismiss" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    if (hasLetter) {
        [shett addButtonWithTitle:_LETTER_TITLE];
    }
    if (hasOurView) {
        [shett addButtonWithTitle:_OUR_VIEW_TITLE];
    }
    if (hasTheirView) {
        [shett addButtonWithTitle:_THEIR_VIEW_TITLE];
    }
    
    [shett showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:_LETTER_TITLE]) {
        
         if (currentType != story_arg_letter) {
         
             currentType = story_arg_letter;
             NSUInteger thisTypeSize = [[DateHelper sharedInstance] getNewsSizeForType:currentType];
             NSUInteger dividend = (thisTypeSize /_PER_PAGE) + 1;
             NSString *nextPage = [NSString stringWithFormat:@"%lu", dividend ];
             [self reloadNewsFromPage:nextPage isSearch:NO];

         }
    }
    else if ([title isEqualToString:_OUR_VIEW_TITLE] ) {
        if (currentType != story_arg_our_view) {
            
            currentType = story_arg_our_view;
            NSUInteger thisTypeSize = [[DateHelper sharedInstance] getNewsSizeForType:currentType];
            NSUInteger dividend = (thisTypeSize /_PER_PAGE) + 1;
            NSString *nextPage = [NSString stringWithFormat:@"%lu", dividend ];
            [self reloadNewsFromPage:nextPage isSearch:NO];

        }
    }
    else if ([title isEqualToString:_THEIR_VIEW_TITLE]) {
        if (currentType != story_arg_their_view) {
            
            currentType = story_arg_their_view;
            NSUInteger thisTypeSize = [[DateHelper sharedInstance] getNewsSizeForType:currentType];
            NSUInteger dividend = (thisTypeSize /_PER_PAGE) + 1;
            NSString *nextPage = [NSString stringWithFormat:@"%lu", dividend ];
            [self reloadNewsFromPage:nextPage isSearch:NO];

        }

    }
}


@end
