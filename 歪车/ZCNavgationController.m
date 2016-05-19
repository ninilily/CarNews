//
//  YGNavgationController.m
//  leftView
//



#import "ZCNavgationController.h"

@interface ZCNavgationController ()

@end

@implementation ZCNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *appear = [UINavigationBar appearance];
    [appear setBackgroundImage:[UIImage imageNamed:@"navigation_define_large_bar_back_image"] forBarMetrics:UIBarMetricsDefault];
}
@end
