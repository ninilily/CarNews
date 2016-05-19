//
//  YGLinJianController.m
//


#import "ZCLinJianController.h"
#import "ZCItemModel.h"
@interface ZCLinJianController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrView;
@property (nonatomic,weak) UIImageView *imageV;
@property (nonatomic,weak) UILabel *desLabel;
@property (nonatomic,weak) UIView *upLine;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *priceLabel;
@property (nonatomic,weak) UIView *downLine;
@end
@implementation ZCLinJianController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrView = [[UIScrollView alloc]init];
    [self.view addSubview:scrView];
    scrView.frame = self.view.bounds;
    scrView.delegate = self;
    self.scrView = scrView;
    
    [self setUpSwipGe];
    [self setUpImageView];
    [self setUpButton];
    [self setUpDescriLabel];
    [self setUpLine];
    [self setUpCell];
    [self setUpPrice];
    [self setUpDownLine];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat offsetX = offSetY / 2;
    
    NSLog(@"%f",offSetY);
    if (offSetY < 0) {
        CGFloat scale = (220 - offsetX) / 220;
        CGRect rect = self.imageV.frame;
        rect.origin.y = offSetY;
        rect.size.height = YGScreenH * 0.45 - offSetY ;
        rect.origin.x = offsetX;
        rect.size.width = YGScreenW * scale;
        self.imageV.frame = rect;
    }
}
- (void)setUpDownLine
{
    UIView *downLine = [[UIView alloc]init];
    [self.scrView addSubview:downLine];
    downLine.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:228/255.0 alpha:1.0];
    self.downLine = downLine;
    
    CGFloat lineX = 5;
    CGFloat lineY = CGRectGetMaxY(self.priceLabel.frame) + 10;
    CGFloat lineW = YGScreenW - 5;
    CGFloat lineH = 1;
    self.downLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
    if (CGRectGetMaxY(self.downLine.frame) > YGScreenH) {
        self.scrView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.downLine.frame) + 40);
    }else{
        self.scrView.contentSize = CGSizeMake(0, YGScreenH + 60);
    }
}
- (void)setUpPrice
{
    UILabel *priceLabel = [[UILabel alloc]init];
    [self.scrView addSubview:priceLabel];
    priceLabel.font = [UIFont systemFontOfSize:13];
    CGFloat nameX = 13;
    CGFloat nameY = CGRectGetMaxY(self.nameLabel.frame) + 5;
    CGFloat nameW = YGScreenW;
    CGFloat nameH = 15;
    priceLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    self.priceLabel = priceLabel;
    
    if ([self.itemmodel.price_text isEqualToString:@"0元/套"]) {
        priceLabel.text = @"暂无报价";
    }else{
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"参考价格:%@",self.itemmodel.price_text]];
        [price addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, price.length - 5)];
        [price addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(5, price.length - 5)];
        priceLabel.attributedText = price;
    }
}
- (void)setUpCell
{
    UILabel *nameLabel = [[UILabel alloc]init];
    [self.scrView addSubview:nameLabel];
    nameLabel.text =  self.itemmodel.name;
    nameLabel.font = [UIFont systemFontOfSize:17];
    CGFloat nameX = 13;
    CGFloat nameY = CGRectGetMaxY(self.upLine.frame) + 10;
    CGFloat nameW = YGScreenW;
    CGFloat nameH = 20;
    nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    self.nameLabel = nameLabel;
}
- (void)setUpLine
{
    UIView *upLine = [[UIView alloc]init];
    [self.scrView addSubview:upLine];
    upLine.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:228/255.0 alpha:1.0];
    self.upLine = upLine;
    
    CGFloat lineX = 5;
    CGFloat lineY = CGRectGetMaxY(self.desLabel.frame) + 5;
    CGFloat lineW = YGScreenW - 5;
    CGFloat lineH = 1;
    self.upLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
}
- (void)setUpDescriLabel
{
    UILabel *desLabel = [[UILabel alloc]init];
    [self.scrView addSubview:desLabel];
    CGSize desSize = [self.itemmodel.descript boundingRectWithSize:CGSizeMake(YGScreenW - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size;
    desLabel.textColor = [UIColor grayColor];
    desLabel.font = [UIFont systemFontOfSize:13];
    desLabel.numberOfLines = 0;
    desLabel.text = self.itemmodel.descript;
    desLabel.frame = CGRectMake(8, CGRectGetMaxY(self.imageV.frame) + 5, YGScreenW - 16, desSize.height);
    self.desLabel = desLabel;
}
- (void)setUpImageView
{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, YGScreenW, YGScreenH * 0.45)];
    [imageV setImageWithURL:[NSURL URLWithString:self.itemmodel.cover] placeholderImage:[UIImage imageNamed:@"image"]];
    [self.scrView addSubview:imageV];
    self.imageV = imageV;
}
- (void)setUpButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 50);
    [btn setImage:[UIImage imageNamed:@"navigation_back_button_image_normal"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)setUpSwipGe
{
    UIView *swiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, YGScreenH)];
    [self.view addSubview:swiView];
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pop)];
    swip.direction = UISwipeGestureRecognizerDirectionDown;
    [swiView addGestureRecognizer:swip];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end