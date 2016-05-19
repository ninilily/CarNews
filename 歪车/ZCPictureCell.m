//
//  YGPictureCell.m
//  歪车
//


#import "ZCPictureCell.h"
#import "ZCItemModel.h"

@interface ZCPictureCell()
@property (nonatomic,weak) UIImageView *imaView;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *desLabel;
@property (nonatomic,weak) UILabel *price;
@end

@implementation ZCPictureCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *image = [[UIImageView alloc]init];
        [self addSubview:image];
        image.layer.cornerRadius = 5;
        image.layer.masksToBounds = YES;
        self.imaView = image;
        
        UILabel *name = [[UILabel alloc]init];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        self.nameLabel = name;
        
        UILabel *des = [[UILabel alloc]init];
        [self addSubview:des];
        des.numberOfLines = 2;
        des.font = [UIFont systemFontOfSize:10];
        self.desLabel = des;
        
        UILabel *price = [[UILabel alloc]init];
        [self addSubview:price];
        price.font = [UIFont systemFontOfSize:13];
        self.price = price;
    }
    return self;
}
+ (instancetype)cellWithTableViuew:(UITableView *)tableView
{
    static NSString *ID = @"pic";
    ZCPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCPictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)setItemModel:(ZCItemModel *)itemModel
{
    _itemModel = itemModel;
    
    [self.imaView setImageWithURL:[NSURL URLWithString:itemModel.cover] placeholderImage:[UIImage imageNamed:@"image1"]];
    
    self.nameLabel.text = itemModel.name;
    
    self.desLabel.text = itemModel.descript;
    
    if ([itemModel.price_text isEqualToString:@"0元/套"]) {
        self.price.text = @"暂无报价";
    }else{
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"参考价格:%@",itemModel.price_text]];
        [price addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, price.length - 5)];
        [price addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(5, price.length - 5)];
        self.price.attributedText = price;
    }
}
//自动布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    
    CGFloat imageX = margin;
    CGFloat imageY = margin;
    CGFloat imageW = 60;
    CGFloat imageH = 60;
    self.imaView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat nameX = CGRectGetMaxX(self.imaView.frame) + 5;
    CGFloat nameY = margin;
    CGFloat nameW = YGScreenW - (CGRectGetMaxX(self.imaView.frame) + 10);
    CGFloat nameH = 15;
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat desX = self.nameLabel.frame.origin.x;
    CGFloat desY = CGRectGetMaxY(self.nameLabel.frame) ;
    CGFloat desW = self.nameLabel.frame.size.width;
    CGFloat desH = 25;
    self.desLabel.frame = CGRectMake(desX, desY, desW, desH);
    
    CGFloat priceX = self.nameLabel.frame.origin.x;
    CGFloat priceY = CGRectGetMaxY(self.desLabel.frame) ;
    CGFloat priceW = self.nameLabel.frame.size.width;
    CGFloat priceH = 23;
    self.price.frame = CGRectMake(priceX, priceY, priceW, priceH);
}
@end
