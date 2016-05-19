//
//  YGScroDetail.m
//  歪车
//


#import "ZCScroDetail.h"
#import "ZCPictureModel.h"
#import "ZCPictureCell.h"
@interface ZCScroDetail()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView *tabbleView;
@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) UILabel *label;
@property (nonatomic,weak) UIView *line;
@end
@implementation ZCScroDetail

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView =[[UIImageView alloc]init];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
        label.numberOfLines = 0;
        [self addSubview:label];
        self.label = label;
        
        UIView *view = [[UIView alloc]init];
        [self addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:228/255.0 alpha:1.0];
        self.line = view;
        
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        [self addSubview:table];
        table.delegate = self;
        table.dataSource = self;
        self.tabbleView = table;
    }
    return self;
}
- (void)setPictureModel:(ZCPictureModel *)pictureModel
{
    _pictureModel = pictureModel;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.pictureModel.p_link] placeholderImage:[UIImage imageNamed:@"image"]];
    self.label.text = self.pictureModel.descrip;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = self.frame.size.height * 0.4;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGSize labelSize = [self.pictureModel.descrip boundingRectWithSize:CGSizeMake(self.frame.size.width - 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size;
    CGFloat labelX = 5;
    CGFloat labelY = CGRectGetMaxY(self.imageView.frame) + 7;
    CGFloat labelW = self.frame.size.width - 10;
    CGFloat labelH = labelSize.height;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    if (self.pictureModel.items) {
        
        CGFloat lineX = 13;
        CGFloat lineY = CGRectGetMaxY(self.label.frame) + 4;
        CGFloat lineW = self.frame.size.width;
        CGFloat lineH = 1;
        self.line.frame = CGRectMake(lineX, lineY, lineW, lineH);
        
        CGFloat tableX = 0;
        CGFloat tableY = CGRectGetMaxY(self.label.frame) + 5;
        CGFloat tableW = self.frame.size.width;
        CGFloat tableH = 80 * (self.pictureModel.items.count);
    
        if (tableY + tableH > YGScreenH) {
            tableH = YGScreenH - tableY;
        }

        self.tabbleView.frame = CGRectMake(tableX, tableY, tableW, tableH);
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pictureModel.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCPictureCell *cell = [ZCPictureCell cellWithTableViuew:tableView];
    cell.itemModel = self.pictureModel.items[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.detaildelegate respondsToSelector:@selector(scroDetailDidCell:sendModel:)]) {
        [self.detaildelegate scroDetailDidCell:self sendModel:self.pictureModel.items[indexPath.row]];
    }
}

@end