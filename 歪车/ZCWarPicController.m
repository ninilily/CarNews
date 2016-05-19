//
//  YGWarPicController.m
//  歪车
//


#import "ZCWarPicController.h"
#import "YGWaterFlow.h"
#import "ZCPicWaterCell.h"
#import "ZCPicModel.h"
@interface ZCWarPicController ()<YGWaterFlowDateSource,YGWaterFlowDelegate>
@property (nonatomic,weak) YGWaterFlow *waterFlow;
@property (nonatomic,weak) UIButton *cover;
@property (nonatomic,weak) UIImageView *imaV;
@end
@implementation ZCWarPicController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWaterFlow];
    [self setUpBotton];
}
- (void)setUpWaterFlow
{
    YGWaterFlow *water = [[YGWaterFlow alloc]initWithFrame:CGRectMake(0, 0, YGScreenW, YGScreenH)];
    water.dateSource = self;
    water.waterDelegate = self;
    [self.view addSubview:water];
    self.waterFlow = water;
}
#pragma mark - 数据源方法
/**
 *  一共有多少列
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(YGWaterFlow *)waterflowView
{
    return 2;
}
/**
 *  一共有多少个数据
 */
- (NSUInteger)numberOfCellsInWaterflowView:(YGWaterFlow *)waterflowView
{
    return self.array.count;
}
/**
 *  返回index位置对应的cell
 */
- (YGWaterflowCell *)waterflowView:(YGWaterFlow *)waterflowView cellAtIndex:(NSUInteger)index
{
    ZCPicWaterCell *cell = [ZCPicWaterCell cellWithWaterflowView:waterflowView];
    cell.model = self.array[index];
    return cell;
}
/**
 *  第index位置cell对应的高度
 */
- (CGFloat)waterflowView:(YGWaterFlow *)waterflowView heightAtIndex:(NSUInteger)index
{
    switch (index % 4) {
        case 0: return 110;
        case 1: return 120;
        default: return 110;
    }
}
/**
 *  返回间距
 */
- (CGFloat)waterflowView:(YGWaterFlow *)waterflowView marginForType:(YGWaterflowViewMarginType)type
{
    switch (type) {
        case YGWaterflowViewMarginTypeTop: return 15;
        case YGWaterflowViewMarginTypeBottom: return 20;
        case YGWaterflowViewMarginTypeLeft: return 10;
        case YGWaterflowViewMarginTypeRight: return 10;
        default:
            return 5;
    }
}
/**
 *  选中第index位置的cell
 */
- (void)waterflowView:(YGWaterFlow *)waterflowView didSelectAtIndex:(NSUInteger)index
{
    ZCPicModel *model = self.array[index];
    
    UIButton *cover = [[UIButton alloc] init];
    cover.frame = self.view.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallImg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    self.cover = cover;
    
    UIImageView *imaV = [[UIImageView alloc]init];
    [self.view addSubview:imaV];
    self.imaV = imaV;
    [imaV setImageWithURL:[NSURL URLWithString:model.list_cover]];
    
    
    CGFloat iconW = YGScreenW;
    CGFloat iconH = iconW / 1.5;
    
    self.imaV.frame = CGRectMake(0, -50, iconW, iconH);
    
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.7;
        
        CGFloat iconW = YGScreenW;
        CGFloat iconH = iconW  / 1.5;
        CGFloat iconY = (self.view.frame.size.height - iconH) * 0.5;
        self.imaV.frame = CGRectMake(0, iconY, iconW, iconH);
    }];
}
- (void)smallImg
{
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat iconW = YGScreenW;
        CGFloat iconH = iconW /1.5;
        self.imaV.frame = CGRectMake(0, YGScreenH + 50, iconW, iconH);
        
        self.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
        self.cover = nil;
        [self.imaV removeFromSuperview];
        self.imaV = nil;
    }];
}

- (void)setUpBotton
{
    self.view.backgroundColor = HMColorRGBA(200, 200, 200, 1);
    self.navigationController.navigationBarHidden = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 50);
    [btn setImage:[UIImage imageNamed:@"navigation_back_button_image_normal"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end