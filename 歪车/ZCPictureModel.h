//
//  YGPictureModel.h
//  歪车
//


#import <Foundation/Foundation.h>

@interface ZCPictureModel : NSObject
/*
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
 }

 */
@property (nonatomic,copy) NSString *descrip;
@property (nonatomic,copy) NSString *p_link;
@property (nonatomic,strong) NSArray *items;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
