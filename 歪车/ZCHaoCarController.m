//
//  YGHaoCarController.m
//  歪车
//


#import "ZCHaoCarController.h"
#import "ZCHaocheFirModel.h"
#import "ZCHaocheCell.h"
#import "ZCHaoDetailController.h"
#import "ZCAdsCell.h"
#import "ZCAdsModel.h"
@interface ZCHaoCarController ()<YGAdsCellDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *adsArray;
@property (nonatomic,assign) NSInteger pageNumber;
@property (nonatomic,copy) NSString *adsStr;
@end
@implementation ZCHaoCarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRefresh];
}
//设置刷新
- (void)setRefresh
{
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNumber = 1;
        [weakSelf loadNetDataPage:[NSString stringWithFormat:@"%ld",self.pageNumber] IsRemoveArray:YES];
    }];
    [self.tableView.header beginRefreshing];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
//加载数据
- (void)loadMoreData
{
    self.pageNumber++;
    [self loadNetDataPage:[NSString stringWithFormat:@"%ld",self.pageNumber] IsRemoveArray:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
//数据懒加载
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)adsArray
{
    if (_adsArray == nil) {
        _adsArray = [NSMutableArray array];
    }
    return _adsArray;
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZCAdsCell *cell = [ZCAdsCell cellWithTableView:tableView];
        cell.array = self.adsArray;
        cell.delegate = self;
        return cell;
    }else{
        ZCHaocheCell *cell = [ZCHaocheCell cellWithTableView:tableView];
        cell.model = self.dataArray[indexPath.row - 1];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return YGScreenH * 0.35;
    }else{
        return YGScreenH * 0.4;
    }
}
- (void)loadNetDataPage:(NSString *)page IsRemoveArray:(BOOL)isRemoveArray
{
    NSString *newStr = YGHaoche;
    if ([page intValue] > 1) {
        newStr = [NSString stringWithFormat:@"%@/page/%@",YGHaoche,page];
    }
    NSDictionary *parameter = @{@"cat" : @"177"
                                };
    
    __weak __typeof(self) weakSelf = self;
    [ZCTool sendGETWithUrl:newStr parameters:parameter success:^(id data) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        
        NSDictionary *backDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *post_list = backDict[@"post_list"];
        NSArray *top_list = backDict[@"top_list"];
        
        if (isRemoveArray) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.adsArray removeAllObjects];
        }
        for (NSDictionary *dict in post_list) {
            ZCHaocheFirModel *model = [ZCHaocheFirModel objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        if ([page intValue] == 1) {
            for (NSDictionary *dict in top_list) {
                ZCAdsModel *adsModel = [ZCAdsModel objectWithKeyValues:dict];
                [weakSelf.adsArray addObject:adsModel];
            }
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZCHaoDetailController *detail = [[ZCHaoDetailController alloc]init];
    if (indexPath.row != 0) {
        detail.model = self.dataArray[indexPath.row - 1];
    }
    [self.navigationController pushViewController:detail animated:YES];
}
//列表跳转到详情页
- (void)adsCellDidSelected:(ZCAdsModel *)model
{
    ZCHaoDetailController *detail = [[ZCHaoDetailController alloc]init];
    detail.adsUrl = model.url;
    detail.pic = model.pic;
    [self.navigationController pushViewController:detail animated:YES];
}
@end