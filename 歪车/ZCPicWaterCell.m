//
//  YGPicWaterCell.m
//  歪车
//


#import "ZCPicWaterCell.h"
#import "YGWaterFlow.h"
#import "ZCPicModel.h"
@interface ZCPicWaterCell()
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation ZCPicWaterCell

+ (instancetype)cellWithWaterflowView:(YGWaterFlow *)waterflow
{
    static NSString *ID = @"SHOP";
    ZCPicWaterCell *cell = [waterflow dequeueReusableItemWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCPicWaterCell alloc] init];
        cell.identifier = ID;
    }
    return cell;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)setModel:(ZCPicModel *)model
{
    _model = model;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:model.list_cover] placeholderImage:[UIImage imageNamed:@"loading"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
@end
