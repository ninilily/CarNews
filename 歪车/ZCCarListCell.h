//
//  YGCarListCell.h
//  歪车
//


#import <UIKit/UIKit.h>
@class ZCCar;
@interface ZCCarListCell : UITableViewCell
+ (instancetype)cellWithtableView:(UITableView *)tableView;
@property (nonatomic,strong) ZCCar *model;
@end
