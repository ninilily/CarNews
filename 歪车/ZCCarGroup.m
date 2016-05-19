//
//  YGCarGroup.m
//  歪车
//


#import "ZCCarGroup.h"
#import "ZCCar.h"
@implementation ZCCarGroup
+ (instancetype)carWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.firstLetter = dict[@"firstLetter"];
        
        NSArray *array = dict[@"lists"];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *listDict in array) {
            ZCCar *car = [ZCCar carWithDict:listDict];
            [dataArray addObject:car];
        }
        
        self.listsArray = dataArray;
    }
    return self;
}
@end
