//
//  YGItemModel.m
//  歪车
//


#import "ZCItemModel.h"

@implementation ZCItemModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.descript = dict[@"description"];
        self.price_text = dict[@"price_text"];
        self.cover = dict[@"cover"];
    }
    return self;
}
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
