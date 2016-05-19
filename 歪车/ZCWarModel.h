//
//  YGWarModel.h
//  歪车
//


#import <Foundation/Foundation.h>
@class ZCPicListModel;
@interface ZCWarModel : NSObject
@property (nonatomic,copy) NSString *pic2;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) ZCPicListModel *pic_posts_list;
@end
