//
//  YGNiuCheCell.m
//  歪车
//


#import "ZCNiuCheCell.h"
#import "ZCNiuCheModel.h"
@interface ZCNiuCheCell()
@property (nonatomic,weak) UIImageView *imaView;
@property (nonatomic,weak) UILabel *priceLabel;
@property (nonatomic,weak) UILabel *label;
@end

@implementation ZCNiuCheCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imaView = [[UIImageView alloc]init];
        [self addSubview:imaView];
        self.imaView = imaView;
        
        UILabel *priceLabel = [[UILabel alloc]init];
        priceLabel.font = [UIFont boldSystemFontOfSize:13];
        priceLabel.textColor = [UIColor whiteColor];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont boldSystemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        self.label = label;
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"id";
    ZCNiuCheCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCNiuCheCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    
    CGFloat labelX = 10;
    CGFloat labelW = YGScreenW;
    CGFloat labelH = 20;
    CGFloat labelY = self.frame.size.height - labelH - 10;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGFloat priceX = 10;
    CGFloat priceW = YGScreenW;
    CGFloat priceH = 20;
    CGFloat priceY = self.label.frame.origin.y - 20;
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
}
- (void)setModel:(ZCNiuCheModel *)model
{
    _model = model;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"image"]];
    self.label.text = model.name;
    if ([model.price intValue] == 0) {
        self.priceLabel.text = @"暂无报价";
    }else{
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"整套改装报价: %@元/套",model.price]];
        [price addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, price.length - 8)];
        [price addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(8, price.length - 8)];
        self.priceLabel.attributedText = price;
    }
}
@end
