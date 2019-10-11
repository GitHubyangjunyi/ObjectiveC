//
//  main.m
//  AAAAReadMe
//
//  Created by 杨俊艺 on 2019/8/30.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>

extern void _objc_autoreleasePoolPrint(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        id __strong obj = [[NSObject alloc] init];
        
        _objc_autoreleasePoolPrint();
        
        id __weak o = obj;
        NSLog(@"Before using __weak: retain count = %d", _objc_rootRetainCount(obj));
        NSLog(@"class = %@", [o class]);
        
        NSLog(@"After using __weak: retain count = %d", _objc_rootRetainCount(obj));
        
        _objc_autoreleasePoolPrint();
        
        
    }
    return 0;
}

/*
 //参考书目:
 //Objective-C编程 第二版 Aaron Hillegass/Mikey Ward 著 华中科技大学出版社
 //Objective-C高级编程 IOS与OS X多线程和内存管理 Kazuki Sakamoto/Tomohiko Furumoto 著 人民邮电出版社
 //Objective-C编程之道 IOS设计模式解析 Carlo Chung 著 人民邮电出版社
*/

//项目索引
//000//AAAAReadMe
//002//AllocInit            对象创建与初始化与id类型
//014//Appliances           对象初始化过程
//015//AppliancesX          继承关系间对象初始化过程
//Blocks        Block对象
    //000//BlockAnonymous                   匿名Block对象
    //003//BlockCapture                     捕获自动变量值瞬时值
    //004//BlockImplement                   Block是如何实现的
    //007//BlockImplementBlock              Block是如何实现的/__block
    //008//BlockImplementBlockForwarding    __block变量结构体实例的__forwarding指针的作用
    //006//BlockImplementBlockPre           Block是如何实现的/__block
    //005//BlockImplementStatic             Block是如何实现的/改写静态变量
    //000//BlockNotifications               使用Block对象订阅通知
    //002//BlockReturnValue                 Block对象的返回值
    //009//BlockSelf                        在Block中避免强引用循环/在Block对象中无意捕获self/修改外部变量
    //001//BlockTypedef                     Block语法
    //031//VoweIMovement                    Block对象
//028//Categories           范畴 为任何已有的类添加方法
//003//ClassDefine          自定义类
//008//ClassExtensions      类扩展/或者称为匿名范畴/隐藏可变属性/头文件与继承/头文件与生成的实例变量
//Collection    集合类型
    //1//AtIndex            测试插入和删除行为
    //2//PropertyList       属性列表/XML
//000//CopyMutableCopy      拷贝的可变性以及Block对象的copy修饰 (还有很多问题待解释)
//013//CString              C字符串/转换成NSString编码问题
//EventDriven   事件驱动
    //029//CallBacks        回调汇总
    //020//HelperObjects    辅助对象/此时称辅助对象为委托对象,别的场景下称为数据源
    //024//KVO              键值观察(Cocoa bindings以及Core Data的关键组成部分)/继承关系中的KVO使用context进行验证
    //026//KVODependentProperties       KVO独立的属性
    //025//KVOExplicitlyNotification    KVO显式触发通知/willChangeValueForKey/didChangeValueForKey
    //027//KVORuntime       KVO工作原理
    //021//Notifications    通知/回调与对象所有权
    //018//NSRunLoop        运行循环/事件驱动
    //019//TargetAction     目标-动作对/选择器工作机制/@selector编译指令
//017//FileOperations       NSString/文件操作错误处理/UTF编码问题/特别目录
//023//IMP                  类的继承层次/IMP类型 (有错误未修正)
//005//Inheritance          继承关系
//006//IsAPointer           isa指针/选择器的工作机制/@selector编译指令
//016//KVC                  KVC/Key路径/Core Data的关键
//009//MemoryLeaks          强引用循环导致的内存泄漏
//012//NS_ENUM              枚举宏和NSMutableArray
//001//ObjectiveC           日期与时间
//007//ObjectOwnership      对象所有权与ARC
//004//Properties           属性
//030//Protocols            协议
//022//Runtime              Objective-C运行时/自省/动态查找并执行方法/注册的类数量
//010//WeakReferences       父子对象之间的弱引用
//011//WeakReferencesZeroing 弱引用自动置零特性/手动引用计数与ARC历史/Retain计数规则/数组排序
