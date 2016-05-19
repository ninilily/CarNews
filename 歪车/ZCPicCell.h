//
//  YGPicCell.h
//  歪车
//


#import <UIKit/UIKit.h>
@class ZCWarModel;
@interface ZCPicCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) ZCWarModel *model;
@end
