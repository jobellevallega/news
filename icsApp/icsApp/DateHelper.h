//
//  DateHelper.h
//  mcHealth
//
//  Created by Jobelle Vallega on 6/13/15.
//  Copyright (c) 2015 Jobelle Vallega. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateHelper : NSObject

+ (DateHelper *)sharedInstance;
#pragma mark - General

-(void)saveWithCompletion:(void(^)(void))completed;

-(void)getNewsForType:(storyType)type
       withCompletion:(void(^)(NSArray *stories))completed;

-(NSArray *)getNewsSearch:(NSString*)searchString;

-(NSUInteger)getNewsSizeForType:(storyType)type;
-(BOOL)hasAlreadyStoredInLocal:(NSDictionary *)thisArticle;

@end
