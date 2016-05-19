//
//  YGNiuCheCell.h
//  歪车
//


#import <UIKit/UIKit.h>
@class ZCNiuCheModel;
@interface ZCNiuCheCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) ZCNiuCheModel *model;
@end
