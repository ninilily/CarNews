//
//  YGCarListCell.m
//  歪车
//


#import "ZCCarListCell.h"
#import "ZCCarGroup.h"
#import "ZCCar.h"

@interface ZCCarListCell()
@property (nonatomic,weak) UIView *divider;
@end
@implementation ZCCarListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor lightGrayColor];
        divider.alpha = 0.5;
        [self.contentView addSubview:divider];
        self.divider = divider;
    }
    return self;
}
+ (instancetype)cellWithtableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    ZCCarListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCCarListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (void)setModel:(ZCCar *)model
{
    _model = model;
    [self.imageView setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"image1"]];
    self.textLabel.text = model.name;
    self.detailTextLabel.text = model.country;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat image = 50;
    
    CGFloat imageX = margin * 2.5;
    CGFloat imageY = margin;
    CGFloat imageH = image;
    CGFloat imageW = image;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    CGFloat textX = CGRectGetMaxX(self.imageView.frame) + 20;
    CGFloat textY = margin;
    CGFloat textH = YGScreenW - 70;
    CGFloat textW = margin * 2;
    self.textLabel.frame = CGRectMake(textX, textY, textH, textW);
    
    CGFloat detailX = self.textLabel.frame.origin.x;
    CGFloat detailY = 40;
    CGFloat detailH = YGScreenW - 70;
    CGFloat detailW = margin * 2;
    self.detailTextLabel.frame = CGRectMake(detailX, detailY, detailH, detailW);
    
    self.divider.frame = CGRectMake(0, 69, YGScreenW, 1);
}
@end
