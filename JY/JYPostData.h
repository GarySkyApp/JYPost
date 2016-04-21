//
//  JYPostData.h
//  Post
//
//  Created by Gary on 16/4/21.
//  Copyright © 2016年 Gary. All rights reserved.
//

/**
    封装AFNetworking，使用Filter来过滤结果（包含关于网络请求结果的逻辑）
 */

/**
    切换页面的时候，取消网络请求
 */



#import <UIKit/UIKit.h>
#import "JYPostFilter.h"

@interface JYPostData : UIImageView

+(void) cancel;

+(void)jyPostNewWithFilter:(JYPostFilter *)filter;
+(void)jyPostMoreWithFilter:(JYPostFilter *)filter;

@end
