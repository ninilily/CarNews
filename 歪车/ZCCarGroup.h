//
//  YGCarGroup.h
//  歪车
//


#import <Foundation/Foundation.h>

@interface ZCCarGroup : NSObject
@property (nonatomic,copy) NSString *firstLetter;
@property (nonatomic,strong) NSArray *listsArray;

+ (instancetype)carWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
