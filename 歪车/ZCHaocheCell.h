//
//  YGHaocheCell.h
//  歪车
//



#import <UIKit/UIKit.h>
@class ZCHaocheFirModel;
@interface ZCHaocheCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) ZCHaocheFirModel *model;
@end
