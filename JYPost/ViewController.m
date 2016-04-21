//
//  ViewController.m
//  JYPost
//
//  Created by Gary on 16/4/21.
//  Copyright © 2016年 Gary. All rights reserved.
//

#import "ViewController.h"
#import "JYPostData.h"
#import "JYPostFilter.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self testPOST];
}

-(void) testPOST{
    
    JYPostFilter *filter = [[JYPostFilter alloc] init];
    filter.resault = ^(id json, NSString *tag){NSLog(@"%@的数据",tag);};
    filter.endRush = ^(NSString *tag){
        NSLog(@"%@结束",tag);
        NSLog(@"==========================\n\n");};
    filter.restartMoreInfo = ^(){NSLog(@"还有更多");};
    filter.noMoreInfo = ^(){NSLog(@"没有更多了");};
    
    
    
    [JYPostData jyPostMoreWithFilter:filter];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYPostData jyPostMoreWithFilter:filter];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYPostData jyPostMoreWithFilter:filter];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYPostData jyPostMoreWithFilter:filter];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYPostData jyPostMoreWithFilter:filter];
    });
    //==========================================================================================
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYPostData jyPostNewWithFilter:filter];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYPostData jyPostMoreWithFilter:filter];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYPostData jyPostMoreWithFilter:filter];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JYPostData jyPostMoreWithFilter:filter];
    });
}

@end
