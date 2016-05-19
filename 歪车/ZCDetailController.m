//
//  YGDetailController.m
//  歪车
//


#import "ZCDetailController.h"
#import "ZCNiuCheModel.h"
#import "ZCPictureModel.h"
#import "ZCScroDetail.h"
#import "ZCLinJianController.h"
@interface ZCDetailController ()<YGScroDetailDelegate>
@end
@implementation ZCDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpBigScroll];
    [self setUpButton];
    
}
- (void)setUpBigScroll
{
    UIScrollView *bigView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, YGScreenW, YGScreenH)];
    [self.view addSubview:bigView];
    bigView.bounces = NO;
    bigView.pagingEnabled = YES;
    for (int i = 0; i < self.model.picturesArray.count; i ++) {
        ZCScroDetail *samView = [[ZCScroDetail alloc]initWithFrame:CGRectMake(i * YGScreenW, 0, YGScreenW, YGScreenH)];
        samView.detaildelegate = self;
        samView.pictureModel = self.model.picturesArray[i];
        [bigView addSubview:samView];
    }
    bigView.contentSize = CGSizeMake(self.model.picturesArray.count * YGScreenW, 0);
}
- (void)setUpButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 50);
    [btn setImage:[UIImage imageNamed:@"navigation_back_button_image_normal"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.navigationController.navigationBarHidden = NO;
}
//再次进入下个详情页面
- (void)scroDetailDidCell:(ZCScroDetail *)detail sendModel:(ZCItemModel *)itemModel
{
    ZCLinJianController *controller = [[ZCLinJianController alloc]init];
    controller.itemmodel = itemModel;
    [self presentViewController:controller animated:YES completion:nil];
}
@end