//
//  YGMainController.m
//  leftView
//


#import "ZCMainController.h"
#import "ZCHaoCarController.h"
#import "ZCWarCarController.h"
#import "ZCNbCarController.h"
#import "ZCCarListController.h"
#import "ZCLetfMenuView.h"
#import "ZCNavgationController.h"

#define YGNavShowAnimDuration 0.4
#define YGCoverTag 100
@interface ZCMainController ()<YGLetfMenuViewDelagate>
@property (nonatomic,weak) ZCNavgationController *showingNavigationController;
@end
@implementation ZCMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBackImage];
    [self addChildViewControllers];
    
    
    ZCLetfMenuView *leftMenu = [[ZCLetfMenuView alloc] init];
    leftMenu.delegate = self;
    leftMenu.height = 300;
    leftMenu.width = 200;
    leftMenu.y = 60;
    [self.view insertSubview:leftMenu atIndex:1];
}
//添加子视图控制器
- (void)addChildViewControllers
{
    ZCHaoCarController *haoche = [[ZCHaoCarController alloc]init];
    [self setupVc:haoche title:@"豪车展汇"];
    
    ZCWarCarController *warCar = [[ZCWarCarController alloc]init];
    [self setupVc:warCar title:@"汽车通缉"];
    
    ZCNbCarController *detail = [[ZCNbCarController alloc]init];
    [self setupVc:detail title:@"牛车改装"];
    
    ZCCarListController *carList = [[ZCCarListController alloc]init];
    [self setupVc:carList title:@"车标简介"];
}
//设置子视图控制器的标题和导航条
- (void)setupVc:(UIViewController *)vc title:(NSString *)title
{
    vc.title = title;

    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"home_user_info_button_normal" target:self action:@selector(menu)];
    
    ZCNavgationController *nav = [[ZCNavgationController alloc] initWithRootViewController:vc];

    [self addChildViewController:nav];
}
//菜单
- (void)menu
{
    [UIView animateWithDuration:YGNavShowAnimDuration animations:^{
        // 取出正在显示的导航控制器的view
        UIView *showingView = self.showingNavigationController.view;
        
        // 缩放比例
        CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * 60;
        CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
        
        // 菜单左边的间距
        CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) * 0.5;
        CGFloat translateX = 200 - leftMenuMargin;
        
        CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
        CGFloat translateY = topMargin - 60;
        
        // 缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        // 平移
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, -translateY / scale);
        
        showingView.transform = translateForm;
        
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
        cover.tag = YGCoverTag;
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = showingView.bounds;
        [showingView addSubview:cover];
    }];
}
- (void)coverClick:(UIView *)cover
{
    //动画
    [UIView animateWithDuration:YGNavShowAnimDuration animations:^{
        self.showingNavigationController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
}
- (void)setUpBackImage
{
    UIImageView *imaView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imaView.image = [UIImage imageNamed:@"app_guidance_large_back_image@2x.jpg"];
    [self.view addSubview:imaView];
}
- (void)leftMenu:(ZCLetfMenuView *)menu didSelectedButtonFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    ZCNavgationController *oldNav = self.childViewControllers[fromIndex];
    [oldNav.view removeFromSuperview];
    
    // 1.显示新控制器的view
    ZCNavgationController *newNav = self.childViewControllers[toIndex];
    [self.view addSubview:newNav.view];
    
    // 2.设置新控制的transform跟旧控制器一样
    newNav.view.transform = oldNav.view.transform;
    // 设置阴影
    newNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    newNav.view.layer.shadowOffset = CGSizeMake(-10, 0);
    newNav.view.layer.shadowOpacity = 0.7;
    
    // 一个导航控制器的view第一次显示到它的父控件上时，如果transform的缩放值被改了，上面的20高度当时是不会出来
    
    // 2.设置当前正在显示的控制器
    self.showingNavigationController = newNav;
    
    // 3.点击遮盖
    [self coverClick:[newNav.view viewWithTag:YGCoverTag]];
}
@end