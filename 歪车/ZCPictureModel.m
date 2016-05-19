//
//  YGPictureModel.m
//  歪车
//


#import "ZCPictureModel.h"
#import "ZCItemModel.h"
@implementation ZCPictureModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.descrip = dict[@"description"];
        self.p_link = dict[@"p_link"];
        
        NSArray *items = dict[@"items"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict1 in items) {
            ZCItemModel *model = [ZCItemModel modelWithDict:dict1];
            [modelArray addObject:model];
        }
        self.items = modelArray;
    }
    return self;
}
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
