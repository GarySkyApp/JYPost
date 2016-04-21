//
//  JYPost.m
//  Post
//
//  Created by Gary on 16/4/18.
//  Copyright © 2016年 Gary. All rights reserved.
//

#import "JYPost.h"
#import "AFNetworking.h"
#import "XCHudHelper.h"

#define AFSuccess ^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
#define AFError ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)

@interface JYPost (){
    NSURLSessionDataTask *sessionTask;
}

@property (nonatomic, strong) AFHTTPSessionManager *session;
@end

@implementation JYPost

#pragma mark - 初始化
+(instancetype) shareJYPostWithBaseURL:(NSString *)baseURL{
    
    static JYPost *_shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[JYPost alloc] init];
        _shareManager.session = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString: baseURL]];
        
        [_shareManager.session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _shareManager.session.requestSerializer.timeoutInterval = 3.f;
        [_shareManager.session.requestSerializer  didChangeValueForKey:@"timeoutInterval"];
    });
    return _shareManager;
}


-(void)cancel{
    [sessionTask cancel];
}

#pragma mark - 请求
-(void)JYPOST:(NSString *)path
withParameter:(NSDictionary *)parameters
   andResault:(void (^)(id))resault
     andError:(void (^)(id))failure
{
    if (sessionTask) {
        [sessionTask cancel];
    }
    
    sessionTask = [_session POST:path
        parameters:parameters
           success:AFSuccess {
               if ([self cheackResault:responseObject]) {
                   resault(responseObject);
               }else{
                   failure(@"参数不正确");
               }
           }
           failure:AFError {
               
               if(error.code == -999){ // 取消
                   //取消网络请求
               }else{
                   [self warning:@"网络不稳定"];
                   failure(@"网络不稳定");
               }
           }];
}


-(BOOL)cheackResault:(id)json{
    NSString *status = json[@"status"];
    if (status.intValue == 0) {
        return YES;
    }else{
        [self warning:json[@"message"]];
        return NO;
    }
}

#pragma mark - 错误处理
-(void) warning:(NSString *)message{
    //TODO: 待定
    [XCHudHelper showMessage:message];
}
@end
