//
//  YGCarListController.m
//  歪车
//


#import "ZCCarListController.h"
#import "ZCCarListCell.h"
#import "ZCCoverView.h"
#import "ZCCarGroup.h"
#import "ZCCar.h"
@interface ZCCarListController ()<UIWebViewDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) ZCCoverView *coverView;
@property (nonatomic,weak) UIWebView *webView;
@property (nonatomic,weak) UIView *cover;
@property (nonatomic,copy) NSString  *carID;
@end
@implementation ZCCarListController
- (instancetype)init
{
    return [super initWithStyle:UITableViewStylePlain];
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRefresh];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_define_large_bar_back_image"] forBarMetrics:UIBarMetricsDefault];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 70;
    self.tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    
}
- (void)setRefresh
{
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadWithURLAndIsRemove:YES];
    }];
    [self.tableView.header beginRefreshing];
}
#pragma mark --- 懒加载
- (ZCCoverView *)coverView
{
    if (_coverView == nil) {
        _coverView = [[ZCCoverView alloc]init];
    }
    return _coverView;
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZCCarGroup *group = self.dataArray[section];
    return group.listsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCarListCell *cell = [ZCCarListCell cellWithtableView:tableView];
    ZCCarGroup *modelGroup = self.dataArray[indexPath.section];
    cell.model = modelGroup.listsArray[indexPath.row];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZCCarGroup *group = self.dataArray[section];
    return group.firstLetter;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.titleArray;
}
#pragma mark - 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.f;
    [self.view.window addSubview:coverView];
    self.cover = coverView;
    //轻按弹出
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTapped)];
    [coverView addGestureRecognizer:tap];
    
    //滑动消失
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeabc)];
    [coverView addGestureRecognizer:swip];
    
    [UIView animateWithDuration:0.2 animations:^{
        coverView.alpha = 0.5f;
    } completion:^(BOOL finished) {
        ZCCarGroup *group = self.dataArray[indexPath.section];
        self.carID = [group.listsArray[indexPath.row] ID];
        [self addCoverView];
    }];
}

- (void)coverViewTapped
{
    [UIView animateWithDuration:0.3 animations:^{
        self.coverView.frame = CGRectOffset(self.coverView.frame, self.coverView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        self.coverView = nil;
        [UIView animateWithDuration:0.2 animations:^{
            self.cover.alpha = 0;
        } completion:^(BOOL finished) {
            [self.cover removeFromSuperview];
            self.cover = nil;
        }];
    }];
}
- (void)swipeabc
{
    [self coverViewTapped];
}
- (void)addCoverView
{
    [self.view.window addSubview:self.coverView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.coverView.frame = CGRectOffset(self.coverView.frame, - (YGScreenW - 50), 0);
    }];
    NSString *str = [NSString stringWithFormat:@"http://price.cartype.kakamobi.com/api/open/car-type/introduction.htm?brandId=%@",self.carID];
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *news = dict[@"data"];
        
        UIWebView *webView = [[UIWebView alloc] init];
        webView.scrollView.bounces = NO;
        webView.delegate = self;
        webView.frame = CGRectMake(0, self.coverView.frame.origin.y + 20, self.coverView.frame.size.width, self.coverView.frame.size.height);
        
        [self.coverView addSubview:webView];
        self.webView = webView;
        [webView loadHTMLString:news baseURL:nil];
    }];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //WebView与JS混合使用
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages(screenWidth) { "
     "var myimg,oldwidth;"
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > screenWidth){"
     "oldwidth = myimg.width;"
     "myimg.width = screenWidth;"
     "myimg.height = myimg.height * (screenWidth/oldwidth ) * 2;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"
     ];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"ResizeImages(%f)",self.view.frame.size.width-100]];
}
#pragma mark - 网络请求
- (void)loadWithURLAndIsRemove:(BOOL)isRemove
{
    __weak __typeof(self) weakSelf = self;
    [ZCTool sendGETWithUrl:YGCarList parameters:nil success:^(id data) {
        [weakSelf.tableView.header endRefreshing];
        
        NSDictionary *backData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil][@"data"];
        if (isRemove) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.titleArray removeAllObjects];
        }
        for (NSDictionary *dict in backData) {
            ZCCarGroup *group = [ZCCarGroup carWithDict:dict];
            [weakSelf.titleArray addObject:group.firstLetter];
            [weakSelf.dataArray addObject:group];
        }
        [weakSelf.tableView reloadData];
        
    } fail:^(NSError *error) {
        [weakSelf.tableView.header endRefreshing];
    }];
}
@end