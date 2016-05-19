//
//  YGWaterFlow.h
//  瀑布流
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    YGWaterflowViewMarginTypeTop,
    YGWaterflowViewMarginTypeBottom,
    YGWaterflowViewMarginTypeLeft,
    YGWaterflowViewMarginTypeRight,
    YGWaterflowViewMarginTypeColumn,
    YGWaterflowViewMarginTypeRow
}YGWaterflowViewMarginType;

@class YGWaterFlow,YGWaterflowCell;

@protocol YGWaterFlowDateSource <NSObject>
@required
/**
 *  一共有多少个数据
 */
- (NSUInteger)numberOfCellsInWaterflowView:(YGWaterFlow *)waterflowView;
/**
 *  返回index位置对应的cell
 */
- (YGWaterflowCell *)waterflowView:(YGWaterFlow *)waterflowView cellAtIndex:(NSUInteger)index;
@optional
/**
 *  一共有多少列
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(YGWaterFlow *)waterflowView;
@end

@protocol YGWaterFlowDelegate <NSObject>
@optional
/**
 *  第index位置cell对应的高度
 */
- (CGFloat)waterflowView:(YGWaterFlow *)waterflowView heightAtIndex:(NSUInteger)index;
/**
 *  选中第index位置的cell
 */
- (void)waterflowView:(YGWaterFlow *)waterflowView didSelectAtIndex:(NSUInteger)index;
/**
 *  返回间距
 */
- (CGFloat)waterflowView:(YGWaterFlow *)waterflowView marginForType:(YGWaterflowViewMarginType)type;
@end
@interface YGWaterFlow : UIScrollView
@property (nonatomic,weak) id<YGWaterFlowDateSource> dateSource;
@property (nonatomic,weak) id<YGWaterFlowDelegate> waterDelegate;
/**
 *  刷新数据（只要调用这个方法，会重新向数据源和代理发送请求，请求数据）
 */
- (void)reloadData;
/**
 *  cell的宽度
 */
- (CGFloat)cellWidth;

/**
 *  根据标识去缓存池查找可循环利用的cell
 */
- (id)dequeueReusableItemWithIdentifier:(NSString *)identifier;
@end
