//
//  YGPictureCell.h
//  歪车
//


#import <UIKit/UIKit.h>
@class ZCItemModel;
@interface ZCPictureCell : UITableViewCell
+ (instancetype)cellWithTableViuew:(UITableView *)tableView;
@property (nonatomic,strong) ZCItemModel *itemModel;
@end
