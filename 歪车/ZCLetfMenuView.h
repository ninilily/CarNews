//
//  YGLetfMenuView.h
//  leftView



#import <UIKit/UIKit.h>
@class ZCLetfMenuView;
@protocol YGLetfMenuViewDelagate <NSObject>
@optional
- (void)leftMenu:(ZCLetfMenuView *)menu didSelectedButtonFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end

@interface ZCLetfMenuView : UIView
@property (nonatomic,weak) id<YGLetfMenuViewDelagate> delegate;
@end
