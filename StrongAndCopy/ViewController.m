//
//  ViewController.m
//  StrongAndCopy
//
//  Created by 情风 on 2018/6/1.
//  Copyright © 2018年 slwy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *strongArray;
@property (nonatomic, copy) NSArray *copiedArray;

@property (nonatomic, strong) NSMutableArray *strongMutableArray;
@property (nonatomic, copy) NSMutableArray *copiedMutableArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self array];
    [self mutableArray];
}

- (void)array {
    NSMutableArray *tempArray = @[@"1",@"2",@"3"].mutableCopy;
    
    self.strongArray = tempArray;
    self.copiedArray = tempArray;
    
    [tempArray addObject:@"4"];
    
    NSLog(@"self.strongArray.count = %lu",(unsigned long)self.strongArray.count);
    NSLog(@"self.copiedArray.count = %lu",(unsigned long)self.copiedArray.count);
    /*
     结果：
     2018-06-01 09:38:04.022055+0800 StrongAndCopy[5084:120513] self.strongArray.count = 4
     2018-06-01 09:38:04.022183+0800 StrongAndCopy[5084:120513] self.copiedArray.count = 3
     
     结论：
     这里把一个可变数组给了self.strongArray 和 self.copiedArray，copy会复制出一个不可变数组，而strong仅仅只是指针的改变，所以如果修改了tempArray；会导致self.strongArray被意外修改（这往往并不是想要的结果），而self.copiedArray不会受此影响
     */
}

- (void)mutableArray{
    
    NSMutableArray *tempArray = @[@"1", @"2", @"3"].mutableCopy;
    
    self.strongMutableArray = tempArray;
    self.copiedMutableArray = tempArray;
    
    [tempArray addObject:@"4"];
    
//    [self.copiedMutableArray addObject:@"5"];//这里会崩溃，由于使用了copy修饰，会copy出一个不可变数组，调用不可变数组的addObject:方法会因为找不到方法而崩溃

}


@end
