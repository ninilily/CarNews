//
//  YGWarCarController.m
//  歪车
//


#import "ZCWarCarController.h"
#import "ZCWarPicController.h"
#import "ZCWarModel.h"
#import "ZCPicCell.h"
#import "ZCPicListModel.h"
@interface ZCWarCarController ()
@property (nonatomic,strong) NSMutableArray *picArray;
@property (nonatomic,assign) NSInteger pageNumber;
@end
@implementation ZCWarCarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRefresh];
}
- (void)setRefresh
{
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNumber = 1;
        [weakSelf loadDataWithPage:[NSString stringWithFormat:@"%ld",self.pageNumber] isRemove:YES];
    }];
    [self.tableView.header beginRefreshing];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (void)loadMoreData
{
    self.pageNumber++;
    [self loadDataWithPage:[NSString stringWithFormat:@"%ld",self.pageNumber] isRemove:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
//数据懒加载
- (NSMutableArray *)picArray
{
    if (_picArray == nil) {
        _picArray = [NSMutableArray array];
    }
    return _picArray;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.picArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCPicCell *cell = [ZCPicCell cellWithTableView:tableView];
    cell.model = self.picArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YGScreenH * 0.38;
}
- (void)loadDataWithPage:(NSString *)page isRemove:(BOOL)isRemove
{
    NSString *newStr = YGTongji;
    if ([page intValue] > 1) {
        newStr = [NSString stringWithFormat:@"%@/page/%@",YGHaoche,page];
    }
    NSDictionary *parameter = @{@"cat" : @"4638"
                                };
    
    __weak __typeof(self) weakSelf = self;
    [ZCTool sendGETWithUrl:newStr parameters:parameter success:^(id data) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        
        NSDictionary *backDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *post_list = backDict[@"post_list"];
        if (isRemove) {
            [weakSelf.picArray removeAllObjects];
        }
        
        for (NSDictionary *dict in post_list) {
            ZCWarModel *model = [ZCWarModel objectWithKeyValues:dict];
            
            [weakSelf.picArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    } fail:^(NSError *error) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZCWarPicController *war = [[ZCWarPicController alloc]init];
    ZCWarModel *model = self.picArray[indexPath.row];
    war.array = model.pic_posts_list.list;
    [self.navigationController pushViewController:war animated:YES];
}
@end