//
//  YGNiuCheModel.m
//  歪车
//


#import "ZCNiuCheModel.h"
#import "ZCPictureModel.h"
@implementation ZCNiuCheModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    //解析数据
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.price = dict[@"price"];
        
        NSArray *array = dict[@"pictures"];
        NSDictionary *dict1 = [array firstObject];
        self.cover = dict1[@"p_link"];
        
        NSArray *pictArray = dict[@"pictures"];
        NSMutableArray *pictArr = [NSMutableArray array];
        for (NSDictionary *dict2 in pictArray) {
            ZCPictureModel *pict = [ZCPictureModel modelWithDict:dict2];
            [pictArr addObject:pict];
        }
        self.picturesArray = pictArr;
    }
    return self;
}
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
