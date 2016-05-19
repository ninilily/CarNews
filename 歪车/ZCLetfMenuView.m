//
//  YGLetfMenuView.m
//  leftView


#import "ZCLetfMenuView.h"
#import "ZCLeftVIewButton.h"

@interface ZCLetfMenuView()
@property (nonatomic,weak) ZCLeftVIewButton *selectedButton;
@end

@implementation ZCLetfMenuView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat alpha = 0.2;
        
        [self setupBtnWithIcon:@"tabbar_haoche" title:@"豪车展汇" bgColor:HMColorRGBA(202, 68, 73, alpha)];
        [self setupBtnWithIcon:@"tabbar_" title:@"汽车通缉" bgColor:HMColorRGBA(190, 111, 69, alpha)];
        [self setupBtnWithIcon:@"tabbar_NB" title:@"牛车改装" bgColor:HMColorRGBA(76, 132, 190, alpha)];
        [self setupBtnWithIcon:@"tabbar.tongji" title:@"车标简介" bgColor:HMColorRGBA(101, 170, 78, alpha)];
    }
    return self;
}
- (ZCLeftVIewButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title bgColor:(UIColor *)bgColor
{
    ZCLeftVIewButton *btn = [[ZCLeftVIewButton alloc] init];
    btn.tag = self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    // 设置图片和文字
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置按钮选中的背景
    [btn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateSelected];
    
    // 设置高亮的时候不要让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置按钮的内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    return btn;
}

- (void)setDelegate:(id<YGLetfMenuViewDelagate>)delegate
{
    _delegate = delegate;
    
    [self buttonClick:[self.subviews firstObject]];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width;
    CGFloat btnH = self.height / btnCount;
    for (int i = 0; i<btnCount; i++) {
        ZCLeftVIewButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = i * btnH;
    }
}
- (void)buttonClick:(ZCLeftVIewButton *)button
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(leftMenu:didSelectedButtonFromIndex:toIndex:)]) {
        [self.delegate leftMenu:self didSelectedButtonFromIndex:self.selectedButton.tag toIndex:button.tag];
    }
    // 控制按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}
@end