//
//  YGItemModel.h
//  歪车
//


#import <Foundation/Foundation.h>

@interface ZCItemModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *descript;
@property (nonatomic,copy) NSString *price_text;
@property (nonatomic,copy) NSString *cover;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
