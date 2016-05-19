//
//  YGPicWaterCell.h
//  歪车
//


#import "YGWaterflowCell.h"
@class YGWaterFlow,ZCPicModel;
@interface ZCPicWaterCell : YGWaterflowCell
+ (instancetype)cellWithWaterflowView:(YGWaterFlow *)waterflow;
@property (nonatomic, strong) ZCPicModel *model;
@end
