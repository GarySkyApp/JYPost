//
//  JYPost.h
//  Post
//
//  Created by Gary on 16/4/18.
//  Copyright © 2016年 Gary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYPost : NSObject

@property (nonatomic, copy) void(^postResault)(id json);

+(instancetype) shareJYPostWithBaseURL:(NSString *)baseURL;

-(void) cancel;

-(void) JYPOST:(NSString *)path
 withParameter:(NSDictionary *)parameters
    andResault:(void(^)(id json)) resault
      andError:(void(^)(id error)) failure;

@end
