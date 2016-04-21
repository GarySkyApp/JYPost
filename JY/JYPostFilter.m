//
//  JYPostFilter.m
//  Post
//
//  Created by Gary on 16/4/21.
//  Copyright © 2016年 Gary. All rights reserved.
//
#define int2str(x) [NSString stringWithFormat:@"%ld",x]

#import "JYPostFilter.h"

@interface JYPostFilter (){
    NSInteger totalPage;
}

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *base;
@property (nonatomic, assign) PostState state;
@property (nonatomic, strong) NSString *newsTag;
@property (nonatomic, strong) NSString *moreTag;
@property (nonatomic, strong) NSString *dataListTag;
@property (nonatomic, strong) NSString *totalPageTag;
@property (nonatomic, strong) NSString *baseTag;

@end


@implementation JYPostFilter
@synthesize page;
@synthesize base;
@synthesize state;
@synthesize newsTag;
@synthesize moreTag;
@synthesize dataListTag;
@synthesize totalPageTag;
@synthesize baseTag;

-(instancetype)init{
    self = [super init];
    if (self) {
        page = 1;
        base = @"0";
        newsTag = @"postNew";
        moreTag = @"postMore";
        dataListTag = @"dataList";
        totalPageTag = @"totalPage";
        baseTag = @"base";
    }
    return self;
}


-(NSString *)getPage{
    return int2str(page);
}

-(NSString *)getBase{
    return base;
}

-(PostState )getState{
    return state;
}

/**
 请求结束
 */
-(void)postEnd:(NSString *)pTag{
    if (_endRush) {
        _endRush(pTag);
    }
}

/**
 请求结果
 */
-(void)postResautl:(id)json andTag:(NSString *)pTag{
    if ([pTag isEqualToString:newsTag]) {
        [self handlingPostNew:json];
    }else{
        [self handlingPostMore:json];
    }
}

/**
 请求到最新操作
 */
-(void) handlingPostNew:(id)json{
    
    if ([json[dataListTag] count] == 0) {
        return ;
    }
    //初始化环境
    NSString *maxPage = json[totalPageTag];
    totalPage = maxPage.intValue;
    base = json[baseTag];
    page = 1;
    //判断是否有更多
    if (page<totalPage) {
        //TODO: 有更多数据
        [self restartMore];
        page++;
    }else{
        [self noMore];
    }
    //
    [self resault:json[dataListTag] andTag:newsTag];
}


/**
 请求到更多操作
 */
-(void) handlingPostMore:(id)json{
    
    if ([json[dataListTag] count] == 0) {
        return ;
    }
    //初始化环境
    NSString *maxPage = json[totalPageTag];
    totalPage = maxPage.intValue;
    base = json[baseTag];
    //判断是否有更多
    if (page<totalPage) {
        //TODO: 有更多数据
        [self restartMore];
        page ++;
    }else{
        [self noMore];
    }
    //
    [self resault:json[dataListTag] andTag:moreTag];
}



/**
 没有更多了
 */
-(void) noMore{
    state = PostStateNoMore;
    if (_noMoreInfo) {
        _noMoreInfo();
    }
}

/**
 有更多
 */
-(void) restartMore{
    state = PostStateMore;
    if (_restartMoreInfo) {
        _restartMoreInfo();
    }
}

/**
 结果
 */
-(void) resault:(id) json andTag:(NSString *)tag{
    //    NSLog(@"数据：%@",tag);
    //    NSLog(@"下一页数：%ld, 总页数：%ld, 基数:%@\n",page, totalPage, base);
    
    if (_resault) {
        _resault(json, tag);
    }
}

/**
 请求错误
 */
-(void) postError:(NSString *)tag{
    NSLog(@"%@ 错误",tag);
}

@end
