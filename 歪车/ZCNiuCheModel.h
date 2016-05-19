//
//  YGNiuCheModel.h
//  歪车


#import <Foundation/Foundation.h>

@interface ZCNiuCheModel : NSObject
/*
 "cases": [
 {
 "car_detail_id": 6236,
 "picture_num": 12,
 "car_detail": "20102.0TSI 豪华版",
 "is_new": true,
 "brand_id": 1,
 "create_time": "1459482985",
 "is_favorite": false,
 "designer_id": 467,
 "top_count": 0,
 "car_year": "2010",
 "brand_picture_position": 0,
 "id": 1601,
 "case_label": "大众改装,CC改装,德系改装,性能改装,内饰改装,,",
 "pictures": [
 {
 "share_num": 1,
 "description": "一汽-大众CC被很多人认为是大众品牌有史以来外观最好看的一款车，在我眼里它就好像一位风度翩翩的绅士，有外在，也有内涵。今天牛车改装为大家带来了一辆一汽-大众CC的实拍改装案例，它拥有350马力，并且还装置了四驱系统。下面就让我们看看被誉为大众最好看的一款车是如何被车主改装的吧！",
 "praise_num": 0,
 "items": [
 
 ],
 "p_link": "http://img.nextcar.cn/modipic/2016_03_31/2215a5959809ac8e249c1027ca50027d.jpg",
 "favorite_num": 0,
 "comment_count": 0,
 "case_id": 1601,
 "download_num": 0,
 "position": 1,
 "id": 15777,
 "share_link": "http://m.niuche.com/modi/case/1601?type=share",
 "brand_tag_list": [
 
 ]
 },
 
 */
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,strong) NSNumber *price;
@property (nonatomic,strong) NSArray *picturesArray;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
