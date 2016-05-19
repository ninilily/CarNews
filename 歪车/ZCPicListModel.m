//
//  YGPicListModel.m
//  歪车
//

#import "ZCPicListModel.h"
#import "ZCPicModel.h"
@implementation ZCPicListModel
- (NSDictionary *)objectClassInArray
{
    return @{@"list" : [ZCPicModel class]};
}
@end
