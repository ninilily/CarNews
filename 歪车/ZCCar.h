//
//  YGCar.h
//  歪车
//


#import <Foundation/Foundation.h>

@interface ZCCar : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *country;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *ID;

+ (instancetype)carWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
