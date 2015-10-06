//
//  ArticleModel.h
//  
//
//  Created by Jobelle Vallega on 7/22/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSObject+APObjectMapping.h"


@interface ArticleModel : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * headline;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSDate   * published_at;
@property (nonatomic, retain) NSString * teaser;
@property (nonatomic, retain) NSNumber * articleType;

+ (NSMutableDictionary *)objectMapping;

@end
