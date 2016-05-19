//
//  YGCar.m
//  歪车
//


#import "ZCCar.h"

@implementation ZCCar
+ (instancetype)carWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.country = dict[@"country"];
        self.ID = dict[@"id"];
        self.imgUrl = dict[@"imgUrl"];
    }
    return self;
}
@end
