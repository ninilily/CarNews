//
//  YGAdsCell.m
//  歪车
//



#import "ZCAdsCell.h"
#import "ZCAdsModel.h"
@interface ZCAdsCell()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrView;
@property (nonatomic,weak) UIPageControl *page;
@property (nonatomic,weak) UITapGestureRecognizer *tap;
@end
@implementation ZCAdsCell
//纯代码编写Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIScrollView *scrView = [[UIScrollView alloc]init];
        [self addSubview:scrView];
        scrView.bounces = NO;
        scrView.showsHorizontalScrollIndicator = NO;
        self.scrView = scrView;
        
        UIPageControl *page = [[UIPageControl alloc]init];
        page.currentPageIndicatorTintColor = [UIColor redColor];
        page.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:page];
        self.page = page;
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ad";
    ZCAdsCell *cell= [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCAdsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrView.frame = CGRectMake(0, 0, YGScreenW, self.height);
    self.page.frame = CGRectMake(YGScreenW - 30, self.height - 11, 0, 0);
    self.page.numberOfPages = self.array.count;
    self.page.currentPage = 0;

    for (int i = 0; i < self.array.count; i ++ ) {
        ZCAdsModel *adsmodel = self.array[i];
        
        UIImageView *imaV = [[UIImageView alloc]init];
        imaV.frame = CGRectMake(i * YGScreenW, 0, YGScreenW, self.height - 1);
        [self.scrView addSubview:imaV];
        [imaV setImageWithURL:[NSURL URLWithString:adsmodel.pic]];
        imaV.tag = i;
        imaV.userInteractionEnabled = YES;
        [imaV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height * 0.9, YGScreenW , self.height * 0.1 - 1)];
        label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        [imaV addSubview:label];
        label.text = [NSString stringWithFormat:@"%@",adsmodel.title];
    }
    self.scrView.delegate = self;
    self.scrView.contentSize = CGSizeMake(YGScreenW * self.array.count, 0);
    self.scrView.pagingEnabled = YES;
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    long i = tap.view.tag;
    if ([self.delegate respondsToSelector:@selector(adsCellDidSelected:)]) {
        [self.delegate adsCellDidSelected:self.array[i]];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int pageNum = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.array.count;
    self.page.currentPage = pageNum;
}
@end