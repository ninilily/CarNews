//
//  YGCoverView.m
//  歪车
//


#import "ZCCoverView.h"

@interface ZCCoverView()

@end
@implementation ZCCoverView
- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(YGScreenW, 0, YGScreenW - 50, YGScreenH);
    }
    return self;
}
- (void)layoutSubviews
{
    
}
@end
