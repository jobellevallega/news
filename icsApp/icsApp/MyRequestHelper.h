//
//  AppDelegate.h
//  mcHealth
//
//  Created by Jobelle Vallega on 5/11/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//
#import <Foundation/Foundation.h>

#define _PER_PAGE    5



typedef enum storyType : NSUInteger{
    story_featured,
    story_latest,
    story_arg_their_view,
    story_arg_letter,
    story_arg_our_view,
}storyType;

@interface MyRequestHelper : NSObject

+ (MyRequestHelper *)sharedInstance;


-(void)getFeedsFromPage:(NSString *)page
           forStoryType:(storyType)type
         withCompletion:(void(^)(void))completed
                orError:(void(^)(NSString *error))fail;












@end
