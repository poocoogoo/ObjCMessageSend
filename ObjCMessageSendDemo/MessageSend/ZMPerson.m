//
//  ZMPerson.m
//  ObjCMessageSendDemo
//
//  Created by SwiftZimu on 2017/1/10.
//  Copyright © 2017年 SwiftZimu. All rights reserved.
//

#import "ZMPerson.h"
#import <Foundation/Foundation.h>
#include <objc/objc-runtime.h>
#import "ZMDog.h"
#import "ZMCat.h"

void run(id self, SEL _cmd) {
    NSLog(@"🍎 %@ %s", self, sel_getName(_cmd));
}

@implementation ZMPerson

/// 1. 动态模式
/*
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel_isEqual(sel, @selector(run))) {
        class_addMethod(self, sel, (IMP)run, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
*/

+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel_isEqual(sel, @selector(go))) {
        Class class = object_getClass(self);
        class_addMethod(class, sel, (IMP)run, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

/// 2. 快速前向转发模式
/*
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [[ZMDog alloc] init];
}
*/

/// 3. 常规前向模式

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (sel_isEqual(aSelector, @selector(run))) {
        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        return methodSignature;
    } else if (sel_isEqual(aSelector, @selector(run:))) {
        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:i"];
        return methodSignature;
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    ZMDog *dog = [[ZMDog alloc] init];
    ZMCat *cat = [[ZMCat alloc] init];
    if ([dog respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:dog];
    } else if ([cat respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:cat];
    }
}

@end
