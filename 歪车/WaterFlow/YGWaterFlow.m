//
//  YGWaterFlow.m
//  瀑布流
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 YG. All rights reserved.
//

#import "YGWaterFlow.h"
#import "YGWaterflowCell.h"
#define YGWaterflowViewDefaultNumberOfColumns 3
#define YGWaterflowViewDefaultMargin 8
#define YGWaterflowViewDefaultCellH 60
@interface YGWaterFlow ()
@property (nonatomic,strong) NSMutableArray *cellFrames;
@property (nonatomic, strong) NSMutableSet *reusableCells;
@property (nonatomic, strong) NSMutableDictionary *displayingCells;
@end

@implementation YGWaterFlow
- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        self.cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}
- (NSMutableDictionary *)displayingCells
{
    if (_displayingCells == nil) {
        self.displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}
- (NSMutableSet *)reusableCells
{
    if (_reusableCells == nil) {
        self.reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];
}
- (CGFloat)cellWidth
{
    // 总列数
    NSUInteger numberOfColumns = [self numberOfColumns];
    CGFloat leftM = [self marginForType:YGWaterflowViewMarginTypeLeft];
    CGFloat rightM = [self marginForType:YGWaterflowViewMarginTypeRight];
    CGFloat columnM = [self marginForType:YGWaterflowViewMarginTypeColumn];
    return (self.bounds.size.width - leftM - rightM - (numberOfColumns - 1) * columnM) / numberOfColumns;
}
- (void)reloadData
{
    
    //清空之前的所有数据
    // 移除正在正在显示cell
    [self.displayingCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];
    
    // cell的总数
    NSUInteger numberOfCells = [self.dateSource numberOfCellsInWaterflowView:self];
    
    // 总列数
    NSUInteger numberOfColumns = [self numberOfColumns];
    
    // 间距
    CGFloat topM = [self marginForType:YGWaterflowViewMarginTypeTop];
    CGFloat bottomM = [self marginForType:YGWaterflowViewMarginTypeBottom];
    CGFloat leftM = [self marginForType:YGWaterflowViewMarginTypeLeft];
    CGFloat columnM = [self marginForType:YGWaterflowViewMarginTypeColumn];
    CGFloat rowM = [self marginForType:YGWaterflowViewMarginTypeRow];
    
    // cell的宽度
    CGFloat cellW = [self cellWidth];
    
    // 用一个C语言数组存放所有列的最大Y值
    CGFloat maxYOfColumns[numberOfColumns];
    for (int i = 0; i<numberOfColumns; i++) {
        maxYOfColumns[i] = 0;
    }
    
    // 计算所有cell的frame
    for (int i = 0; i<numberOfCells; i++) {
        // cell处在第几列(最短的一列)
        NSUInteger cellColumn = 0;
        // cell所处那列的最大Y值(最短那一列的最大Y值)
        CGFloat maxYOfCellColumn = maxYOfColumns[cellColumn];
        // 求出最短的一列
        for (int j = 1; j<numberOfColumns; j++) {
            if (maxYOfColumns[j] < maxYOfCellColumn) {
                cellColumn = j;
                maxYOfCellColumn = maxYOfColumns[j];
            }
        }
        
        // 询问代理i位置的高度
        CGFloat cellH = [self heightAtIndex:i];
        
        // cell的位置
        CGFloat cellX = leftM + cellColumn * (cellW + columnM);
        CGFloat cellY = 0;
        if (maxYOfCellColumn == 0) { // 首行
            cellY = topM;
        } else {
            cellY = maxYOfCellColumn + rowM;
        }
        
        // 添加frame到数组中
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        
        // 更新最短那一列的最大Y值
        maxYOfColumns[cellColumn] = CGRectGetMaxY(cellFrame);
    }
    
    // 设置contentSize
    CGFloat contentH = maxYOfColumns[0];
    for (int j = 1; j<numberOfColumns; j++) {
        if (maxYOfColumns[j] > contentH) {
            contentH = maxYOfColumns[j];
        }
    }
    contentH += bottomM;
    self.contentSize = CGSizeMake(0, contentH);
}
/**
 *  当UIScrollView滚动的时候也会调用这个方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 向数据源索要对应位置的cell
    NSUInteger numberOfCells = self.cellFrames.count;
    for (int i = 0; i<numberOfCells; i++) {
        // 取出i位置的frame
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        
        // 优先从字典中取出i位置的cell
        YGWaterflowCell *cell = self.displayingCells[@(i)];
        
        // 判断i位置对应的frame在不在屏幕上（能否看见）
        if ([self isInScreen:cellFrame]) { // 在屏幕上
            if (cell == nil) {
                cell = [self.dateSource waterflowView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                
                // 存放到字典中
                self.displayingCells[@(i)] = cell;
            }
        } else {  // 不在屏幕上
            if (cell) {
                // 从scrollView和字典中移除
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                
                // 存放进缓存池
                [self.reusableCells addObject:cell];
            }
        }
    }
}
- (id)dequeueReusableItemWithIdentifier:(NSString *)identifier
{
    __block YGWaterflowCell *reusableCell = nil;
    
    [self.reusableCells enumerateObjectsUsingBlock:^(YGWaterflowCell *cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    
    if (reusableCell) { // 从缓存池中移除
        [self.reusableCells removeObject:reusableCell];
    }
    return reusableCell;
}


#pragma mark - 私有方法
/**
 *  判断一个frame有无显示在屏幕上
 */
- (BOOL)isInScreen:(CGRect)frame
{
    return (CGRectGetMaxY(frame) > self.contentOffset.y) &&
    (CGRectGetMinY(frame) < self.contentOffset.y + self.bounds.size.height);
}
/**
*  index位置对应的高度
*/
- (CGFloat)heightAtIndex:(NSUInteger)index
{
    if ([self.waterDelegate respondsToSelector:@selector(waterflowView:heightAtIndex:)]) {
        return [self.waterDelegate waterflowView:self heightAtIndex:index];
    } else {
        return YGWaterflowViewDefaultCellH;
    }
}

/**
 *  总列数
 */
- (NSUInteger)numberOfColumns
{
    if ([self.dateSource respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return [self.dateSource numberOfColumnsInWaterflowView:self];
    } else {
        return YGWaterflowViewDefaultNumberOfColumns;
    }
}
/**
 *  间距
 */
- (CGFloat)marginForType:(YGWaterflowViewMarginType)type
{
    if ([self.waterDelegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.waterDelegate waterflowView:self marginForType:type];
    } else {
        return YGWaterflowViewDefaultMargin;
    }
}
#pragma mark - 事件处理
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.waterDelegate respondsToSelector:@selector(waterflowView:didSelectAtIndex:)]) return;
    
    // 获得触摸点
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    __block NSNumber *selectIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id key, YGWaterflowCell *cell, BOOL *stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];
    
    if (selectIndex) {
        [self.waterDelegate waterflowView:self didSelectAtIndex:selectIndex.unsignedIntegerValue];
    }
}
@end
