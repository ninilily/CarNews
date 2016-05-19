//
//  YGPicCell.m
//  歪车
//


#import "ZCPicCell.h"
#import "ZCWarModel.h"
@interface ZCPicCell()
@property (nonatomic,weak) UIImageView *imageV;
@property (nonatomic,weak) UILabel *label;
@end

@implementation ZCPicCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imaV = [[UIImageView alloc]init];
        [self addSubview:imaV];
        self.imageV = imaV;
        
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentRight;
        self.label = label;
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"pic";
    ZCPicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(void)setModel:(ZCWarModel *)model
{
    _model = model;
    [self.imageV setImageWithURL:[NSURL URLWithString:model.pic2] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.label.text = model.title;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(0, 0, YGScreenW, self.height - 1);
}
@end
