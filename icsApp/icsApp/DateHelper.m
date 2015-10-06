//
//  DateHelper.m
//  mcHealth
//
//  Created by Jobelle Vallega on 6/13/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import "DateHelper.h"


@implementation DateHelper


+ (DateHelper *)sharedInstance {
    static DateHelper *sharedInstance;
    if (sharedInstance == nil) {
        sharedInstance = [[DateHelper alloc] init];
    }
    return sharedInstance;
}

-(void)getNewsForType:(storyType)type
       withCompletion:(void(^)(NSArray *stories))completed{
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"articleType == %@", [NSNumber numberWithInt:type]];
    NSSortDescriptor *sorting = [NSSortDescriptor sortDescriptorWithKey:@"published_at" ascending:NO];
    NSFetchRequest *newsRequest = [ArticleModel MR_requestAllWithPredicate:filter];
    [newsRequest setSortDescriptors:[NSArray arrayWithObjects:sorting, nil]];
    [newsRequest setReturnsDistinctResults:YES];

    NSArray *stories = [ArticleModel MR_executeFetchRequest:newsRequest];
    NSLog(@"Finished Fetching with results %lu", stories.count);
    completed(stories);

}
-(NSUInteger)getNewsSizeForType:(storyType)type{
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"articleType == %@", [NSNumber numberWithInt:type]];
   
    NSFetchRequest *newsRequest = [ArticleModel MR_requestAllWithPredicate:filter];
    [newsRequest setReturnsDistinctResults:YES];
    
    NSArray *stories = [ArticleModel MR_executeFetchRequest:newsRequest];
  
    NSLog(@"Finished Fetching with results %lu", stories.count);
    return stories.count;
    
    
    
}
-(NSArray *)getNewsSearch:(NSString*)searchString{
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"author CONTAINS[cd]%@  OR body CONTAINS[cd] %@ OR headline CONTAINS[cd] %@ OR teaser CONTAINS[cd] %@ ",searchString,searchString, searchString, searchString ,nil];
    NSFetchRequest *newsRequest = [ArticleModel MR_requestAllWithPredicate:filter];
    [newsRequest setReturnsDistinctResults:YES];
    NSArray *stories = [ArticleModel MR_executeFetchRequest:newsRequest];
    
    NSLog(@"Finished Fetching with results %lu", stories.count);
    return stories;

}

-(void)saveWithCompletion:(void(^)(void))completed{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        // Do your work to be saved here, against the `localContext` instance
        // Everything you do in this block will occur on a background thread
        
    } completion:^(BOOL success, NSError *error) {
        completed();
    }];
}
-(BOOL)hasAlreadyStoredInLocal:(NSDictionary *)thisArticle{
    
    NSString *headline = [thisArticle objectForKey:@"headline"];
    NSString *body = [thisArticle objectForKey:@"body"];
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"headline == %@  AND body == %@", headline, body ,nil];
    NSFetchRequest *newsRequest = [ArticleModel MR_requestAllWithPredicate:filter];
    NSArray *stories = [ArticleModel MR_executeFetchRequest:newsRequest];
    if (stories.count > 0) {
        NSLog(@"Already has this story, so dont store");
        return YES;
    }
    else{

        return NO;
    }
    

}
@end
