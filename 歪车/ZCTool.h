//
//  YGTool.h
//  歪车
//


#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(NSError *error);
@interface ZCTool : NSObject
+ (void)sendGETWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

@end
