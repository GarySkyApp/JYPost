//
//  JYPostFilter.h
//  Post
//
//  Created by Gary on 16/4/21.
//  Copyright © 2016年 Gary. All rights reserved.
//


/**
 1、
    切换页面的时候
 接收端置空
 
    显示页面的时候
 接收端配置
 
 2、或者
    只配置一次，不用置空
 
 */


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PostState){
    PostStateMore,
    PostStateNoMore
};


@interface JYPostFilter : NSObject

@property (nonatomic, copy) void(^resault)(id json, NSString *tag);
@property (nonatomic, copy) void(^noMoreInfo)();
@property (nonatomic, copy) void(^restartMoreInfo)();
@property (nonatomic, copy) void(^endRush)(NSString *tag);

-(NSString *)getPage;
-(NSString *)getBase;
-(PostState )getState;

-(void)postEnd:(NSString *)pTag;
-(void)postResautl:(id)json andTag:(NSString *)pTag;
-(void) postError:(NSString *)tag;
@end
