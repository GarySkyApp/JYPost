//
//  JYPostData.m
//  Post
//
//  Created by Gary on 16/4/21.
//  Copyright © 2016年 Gary. All rights reserved.
//


#define BasePath @""
#define integer2str(x) [NSString stringWithFormat:@"%ld",x]

#import "JYPostData.h"
#import "JYPost.h"

@implementation JYPostData

+(void)cancel{
   [[JYPost shareJYPostWithBaseURL:BasePath] cancel];
}

+(void)jyPostNewWithFilter:(JYPostFilter *)filter{
    //
    JYPost *jy = [JYPost shareJYPostWithBaseURL:BasePath];
    [jy JYPOST:@"/rest/api/photo/list/"
 withParameter:@{
                 @"type":@1,
                 @"page":[filter getPage],
                 @"base":[filter getBase],
                 @"deviceType":@1,
                 @"order":@1
                 }
    andResault:^(id json) {
        [filter postResautl:json andTag:@"postNew"];
        [filter postEnd:@"postNew"];
    }
      andError:^(id error) {
          [filter postError:@"postNew"];
          [filter postEnd:@"postNew"];
      }];

}

+(void)jyPostMoreWithFilter:(JYPostFilter *)filter{
    if ([filter getState] == PostStateNoMore) {
        return ;
    }
    JYPost *jy = [JYPost shareJYPostWithBaseURL:BasePath];
    [jy JYPOST:@"/rest/api/photo/list/"
 withParameter:@{
                 @"type":@1,
                 @"page":[filter getPage],
                 @"base":[filter getBase],
                 @"deviceType":@1,
                 @"order":@1
                 }
    andResault:^(id json) {
        [filter postResautl:json andTag:@"postMore"];
        [filter postEnd:@"postMore"];
    }
      andError:^(id error) {
          [filter postError:@"postMore"];
          [filter postEnd:@"postMore"];
      }];
}



@end
