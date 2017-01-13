//
//  ViewController.m
//  ObjCMessageSendDemo
//
//  Created by SwiftZimu on 2017/1/10.
//  Copyright © 2017年 SwiftZimu. All rights reserved.
//

#import "ViewController.h"
#import "ZMPerson.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [ZMPerson go];
    ZMPerson *person = [[ZMPerson alloc] init];
    [person run];
    [person run:5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
