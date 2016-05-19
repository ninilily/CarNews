//
//  YGScroDetail.h
//  歪车
//


#import <UIKit/UIKit.h>
@class ZCScroDetail,ZCItemModel;
@protocol YGScroDetailDelegate <NSObject>
- (void)scroDetailDidCell:(ZCScroDetail *)detail sendModel:(ZCItemModel *)itemModel;
@end

@class ZCPictureModel;
@interface ZCScroDetail : UIScrollView
@property (nonatomic,strong) ZCPictureModel *pictureModel;
@property (nonatomic,weak) id<YGScroDetailDelegate> detaildelegate;
@end
