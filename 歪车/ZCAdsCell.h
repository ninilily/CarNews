//
//  YGAdsCell.h
//  歪车
//


#import <UIKit/UIKit.h>
@class ZCAdsModel;
@protocol YGAdsCellDelegate <NSObject>
- (void)adsCellDidSelected:(ZCAdsModel *)model;
@end

@interface ZCAdsCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,weak) id<YGAdsCellDelegate> delegate;
@end
