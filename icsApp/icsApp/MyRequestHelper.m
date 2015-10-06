//
//  AppDelegate.h
//  mcHealth
//
//  Created by Jobelle Vallega on 5/11/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import "MyRequestHelper.h"



@implementation MyRequestHelper

+ (MyRequestHelper *)sharedInstance {
    static MyRequestHelper *sharedInstance;
    if (sharedInstance == nil) {
        sharedInstance = [[MyRequestHelper alloc] init];
    }
    return sharedInstance;
}


-(void)getFeedsFromPage:(NSString *)page
           forStoryType:(storyType)type
         withCompletion:(void(^)(void))completed
                orError:(void(^)(NSString *error))fail{
    
    NSString *perPage = [NSString stringWithFormat:@"%d", _PER_PAGE ];
    NSString  *stringURL;
  
    if (type == story_featured) {
        stringURL = [NSString stringWithFormat:@"%@%@&per_page=%@&page=%@", _API_BASE_URL, _API_URL_SUFFIX_FEATURED, perPage, page ];
    }
    else if (type == story_latest){
        
        stringURL = [NSString stringWithFormat:@"%@%@&per_page=%@&page=%@", _API_BASE_URL, _API_URL_SUFFIX_LATEST, perPage, page ];
    }
    else if (type == story_arg_letter){
        
        stringURL = [NSString stringWithFormat:@"%@%@&per_page=%@&page=%@", _API_BASE_URL,_API_URL_SUFFIX_LETTER, perPage, page ];
       
    }
    else if (type == story_arg_our_view){
        
        stringURL = [NSString stringWithFormat:@"%@%@&per_page=%@&page=%@", _API_BASE_URL,_API_URL_SUFFIX_OUR_VIEW, perPage, page ];
        
    }
    else if (type == story_arg_their_view){
        
        stringURL = [NSString stringWithFormat:@"%@%@&per_page=%@&page=%@", _API_BASE_URL,_API_URL_SUFFIX_THEIR_VIEW, perPage, page ];
        
    }


   
     NSLog(@"String url to send %@", stringURL);
    
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:_AUTHORIZATION_KEY forHTTPHeaderField:@"Authorization"];
    [manager GET:stringURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *articles = responseObject;
        
        
        for (NSDictionary *eachArticle in articles) {
            
            if (![[DateHelper sharedInstance] hasAlreadyStoredInLocal:eachArticle]) {
                ArticleModel *newArticle = [ArticleModel MR_createEntity];
                newArticle = [newArticle initWithDictionary:eachArticle];
                newArticle.articleType = [NSNumber numberWithInt:type];
                newArticle.published_at = [[GlobalConfig sharedInstance] processDateGivenString:[eachArticle objectForKey:@"published_at"]];
                newArticle.imageURL = [[GlobalConfig sharedInstance] getImageLinkFromJSON:eachArticle];
                [[DateHelper sharedInstance] saveWithCompletion:^{
                    //
                }];

            }
            
            
        }
        NSLog(@"Finished storing all articles ");
        completed ();
        
     
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
}




@end
