//
//  BNRObserver.m
//  KVO
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRObserver.h"

@implementation BNRObserver

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSString *oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    NSString *newValue = [change objectForKey:NSKeyValueChangeNewKey];
    NSLog(@"Oberser: %@ of %@ was changed from %@ to %@", keyPath, object, oldValue, newValue);
    
}

@end

//在KVO中使用Context
//当在代码中将某个对象注册为观察者时,需要传递指针作为context
//当接收变化的通知时,context会随通知一起发送,context可以用来回答这真的是我需要的通知吗?
//例如父类使用的KVO,如果覆盖了
//  -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//
//如何知道该将哪条消息转发给父类实现呢?可以创建一个单独的指针,在开始观察时将其设置为context,每次收到通知时将它和context进行比对,静态变量的地址可以很好工作
//因此如果子类化某个使用了KVO的类时可以编写以下代码
//
//  static int contextForKVO;
//  ...
//
//  [petOwner addObserver:self
//           forKeyPath:@"fido"
//              options:0
//              context: &contextForKVO];
//...
//
//  -(void)observeValueForKeyPath:(NSString *)keyPath
//                        ofObject:(id)object
//                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
//                        context:(void *)context
//{
//    //这不是我的?
//    if(context != &contextForKVO){
//        //将它传递给父类
//        [super observeValueForKeyPath:keyPath
//                            ofObject:object
//                            change:change
//                              context:context];
//    }else {
//        //处理变化
//    }
//}
//...
