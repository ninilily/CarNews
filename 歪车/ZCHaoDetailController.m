//
//  YGHaoDetailController.m
//  歪车
//



#import "ZCHaoDetailController.h"
#import "ZCHaocheFirModel.h"
#import "ZCAdsModel.h"
#define Off 50
#define YGImageHeight (YGScreenH * 0.39)
@interface ZCHaoDetailController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrView;

@property (nonatomic,weak) UIWebView *webView;
@property (nonatomic,weak) UIImageView *imV;
@property (nonatomic,weak) UIImageView *navView;
@end
@implementation ZCHaoDetailController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setUpBotton];
}
- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    UIScrollView *scrView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrView.delegate = self;
     UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, YGScreenW,  YGImageHeight)];
    [scrView addSubview:imV];
    self.imV = imV;
   UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, YGImageHeight, YGScreenW, YGScreenH - YGImageHeight)];
    webView.delegate = self;
    self.webView = webView;

    [scrView addSubview:webView];
    
    NSURL *url;
    if (self.model.url) {
        url= [NSURL URLWithString:self.model.url];
        [imV setImageWithURL:[NSURL URLWithString:self.model.pic]];
    }else{
        url= [NSURL URLWithString:self.adsUrl];
        [imV setImageWithURL:[NSURL URLWithString:self.pic]];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:scrView];
    self.scrView = scrView;
    //返回按钮
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, YGScreenW, 64)];
    view.image = [UIImage imageNamed:@"navigation_define_large_bar_back_image"];
    view.alpha = 0;
    [self.view addSubview:view];
    self.navView = view;
}
#pragma mark--ScrolViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat offsetX = offSetY / 2;
    //判断下拉高度
    if (offSetY > Off) {
        self.navView.alpha = MIN(1, 1 - ((Off + 64 - offSetY) / 64));
    }else {
        self.navView.alpha = 0;
    }
    if (offSetY < 0) {
        CGFloat scale = (220 - offsetX) / 220;
        CGRect rect = self.imV.frame;
        rect.origin.y = offSetY;
        rect.size.height = YGImageHeight - offSetY;
        rect.origin.x = offsetX;
        rect.size.width = YGScreenW * scale;
        self.imV.frame = rect;
    }
}
//开启应用网络活动
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
//关闭应用网络活动
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    CGRect frame = webView.frame;
    NSString *fitHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    frame.size.height = [fitHeight floatValue];
    webView.frame = frame;
    self.scrView.contentSize = CGSizeMake(0, CGRectGetMaxY(webView.frame));
}
//返回主界面
- (void)setUpBotton
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 14, 50, 50);
    [btn setImage:[UIImage imageNamed:@"navigation_back_button_image_normal"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end