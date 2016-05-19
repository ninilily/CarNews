//
//  YGHaocheCell.m
//  歪车
//


#import "ZCHaocheCell.h"
#import "ZCHaocheFirModel.h"

@interface ZCHaocheCell()
@property (nonatomic,weak) UIImageView *imageV;
@property (nonatomic,weak) UIView *coverV;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *pubLabel;
@end

@implementation ZCHaocheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageV = [[UIImageView alloc]init];
        [self addSubview:imageV];
        self.imageV = imageV;
        
        UIView *coverV = [[UIView alloc]init];
        [self addSubview:coverV];
        coverV.backgroundColor = [UIColor blackColor];
        coverV.alpha = 0.5;
        self.coverV = coverV;
        
        UILabel *nameLable = [[UILabel alloc]init];
        [self addSubview:nameLable];
        nameLable.textColor = [UIColor whiteColor];
        nameLable.numberOfLines = 2;
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.font = [UIFont systemFontOfSize:17];
        self.nameLabel = nameLable;
        
        UILabel *pubLabel = [[UILabel alloc]init];
        [self addSubview:pubLabel];
        pubLabel.numberOfLines = 0;
        pubLabel.textColor = [UIColor whiteColor];
        pubLabel.textAlignment = NSTextAlignmentCenter;
        pubLabel.font = [UIFont systemFontOfSize:15];
        self.pubLabel = pubLabel;
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"haoche";
    ZCHaocheCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCHaocheCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)setModel:(ZCHaocheFirModel *)model
{
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _model = model;
    
    [self.imageV setImageWithURL:[NSURL URLWithString:model.pic]];
    
    self.nameLabel.text = model.title;
    
    self.pubLabel.text = model.brief;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = YGScreenW;
    CGFloat imageH = self.height - 1;
    self.imageV.frame = CGRectMake(imageX, imageY, imageW, imageH);
    self.coverV.frame = self.imageV.frame;
    
    CGSize nameSize = [self.model.title boundingRectWithSize:CGSizeMake(YGScreenW - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat nameX = 30;
    CGFloat nameY = self.height * 0.4;
    CGFloat nameW = YGScreenW - 60;
    CGFloat nameH = nameSize.height;
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGSize pubSize = [self.model.brief boundingRectWithSize:CGSizeMake(YGScreenW - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    CGFloat pubX = 0;
    CGFloat pubY = CGRectGetMaxY(self.nameLabel.frame);
    CGFloat pubW = YGScreenW;
    CGFloat pubH = pubSize.height;
    self.pubLabel.frame = CGRectMake(pubX, pubY, pubW, pubH);
}
@end
