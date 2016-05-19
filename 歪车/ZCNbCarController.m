//
//  YGNbCarController.m
//  歪车
//


#import "ZCNbCarController.h"
#import "ZCDetailController.h"
#import "ZCNiuCheModel.h"
#import "ZCNiuCheCell.h"
@interface ZCNbCarController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger pageNum;
@end
@implementation ZCNbCarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRefresh];
}
- (void)setRefresh
{
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        [weakSelf loadWithPage:[NSString stringWithFormat:@"%ld",self.pageNum] count:@"20" isRemove:YES];
    }];
    [self.tableView.header beginRefreshing];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (void)loadMoreData
{
    self.pageNum++;
    [self loadWithPage:[NSString stringWithFormat:@"%ld",self.pageNum] count:@"20" isRemove:NO];
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCNiuCheCell *cell = [ZCNiuCheCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YGScreenH * 0.39;
}
- (void)loadWithPage:(NSString *)page count:(NSString *)count isRemove:(BOOL)isRemove
{
    //动态拼接参数
    NSDictionary *parDict = @{@"page" : page,
                              @"count" : count,
                              @"citt=" : @""
                              };
    __weak __typeof(self) weakSelf = self;
    [ZCTool sendGETWithUrl:YGNiuChe parameters:parDict success:^(id data) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if([dict isKindOfClass:[NSDictionary class]]){
            NSDictionary *dict1 = (NSDictionary *)dict;
            NSArray *array = dict1[@"cases"];
            if (isRemove) {
                [weakSelf.dataArray removeAllObjects];
            }
            
            for(NSDictionary *dict2 in array){
                ZCNiuCheModel *model = [ZCNiuCheModel modelWithDict:dict2];
                [weakSelf.dataArray addObject:model];
            }
        }
        [weakSelf.tableView reloadData];
    } fail:^(NSError *error) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCNiuCheModel *model = self.dataArray[indexPath.row];
    ZCDetailController *detail = [[ZCDetailController alloc]init];
    detail.model = model;
    self.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:detail animated:YES completion:nil];
}
@end
