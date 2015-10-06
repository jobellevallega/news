//
//  ArticleModel.m
//  
//
//  Created by Jobelle Vallega on 7/22/15.
//
//

#import "ArticleModel.h"


@implementation ArticleModel

@dynamic author;
@dynamic body;
@dynamic headline;
@dynamic imageURL;
@dynamic published_at;
@dynamic teaser;
@dynamic articleType;


+ (NSMutableDictionary *)objectMapping {
    NSMutableDictionary * mapping = [super objectMapping];
    if (mapping) {
        
        NSDictionary * objectMapping = @{ @"author": @"author",
                                          @"body": @"body",
                                          @"headline": @"headline",
                                          @"teaser": @"teaser"
                                          };
        
        [mapping addEntriesFromDictionary:objectMapping];
        
    }
    return mapping;
}


@end
