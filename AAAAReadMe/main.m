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
        
        
//        id __strong obj = [[NSObject alloc] init];
//
//        _objc_autoreleasePoolPrint();
//
//        id __weak o = obj;
//        NSLog(@"Before using __weak: retain count = %d", _objc_rootRetainCount(obj));
//        NSLog(@"class = %@", [o class]);
//
//        NSLog(@"After using __weak: retain count = %d", _objc_rootRetainCount(obj));
//
//        _objc_autoreleasePoolPrint();
        
        
        
        printf("%p\n", main);
        printf("%p\n", &main);
        
        printf("%zu\n", sizeof(char));
        printf("%zu\n", sizeof(char *));
        
        
        printf("%zu\n", sizeof(short));
        printf("%zu\n", sizeof(short *));
        
        printf("int %zu\n", sizeof(int));
        printf("int * %zu\n", sizeof(int *));
        
        
        printf("%zu\n", sizeof(float));
        printf("%zu\n", sizeof(float *));
        
        
        printf("%zu\n", sizeof(double));
        printf("%zu\n", sizeof(double *));
        
        
    }
    return 0;
}

/*
 //参考书目:
 //Objective-C编程 第二版 Aaron Hillegass/Mikey Ward 著 华中科技大学出版社
 //Objective-C高级编程 IOS与OS X多线程和内存管理 Kazuki Sakamoto/Tomohiko Furumoto 著 人民邮电出版社
 //Objective-C编程全解 荻原刚志 著 人民邮电出版社
 //Objective-C编程之道 IOS设计模式解析 Carlo Chung 著 人民邮电出版社
*/

//项目索引
//000//AAAAReadMe
//008//AccessRights  访问权限
    //001//RGB              无访问修饰
    //002//RGBS             protect
    //003//RGBX             private
//012//Appliances           对象初始化过程
//013//AppliancesX          继承关系间对象初始化过程
//000//Blocks        Block对象
    //001//BlockAnonymous                   匿名Block对象
    //003//BlockCapture                     捕获自动变量值瞬时值
    //00//BlockImplement                   Block是如何实现的
    //007//BlockImplementBlock              Block是如何实现的/__block
    //008//BlockImplementBlockForwarding    __block变量结构体实例的__forwarding指针的作用
    //006//BlockImplementBlockPre           Block是如何实现的/__block
    //005//BlockImplementStatic             Block是如何实现的/改写静态变量
    //000//BlockNotifications               使用Block对象订阅通知
    //002//BlockSelf                        在Block中避免强引用循环/在Block对象中无意捕获self/修改外部变量
    //000//BlockTypedef                     Block语法
    //031//VoweIMovement                    Block对象
//005//Categories           范畴 为任何已有的类添加方法
//002//ClassDefineProperties
    //1//ClassDefine          自定义类使用实例变量
    //2//ClassProperties      自定义类使用属性
//004//ClassExtensions      类扩展/或者称为匿名范畴/隐藏可变属性/头文件与继承/头文件与生成的实例变量
//011//Collection    集合类型
    //001//AtIndex          测试插入和删除行为/封装对象放进集合中
    //002//PropertyList       属性列表/XML
//000//CopyMutableCopy      拷贝的可变性以及Block对象的copy修饰 (还有很多问题待解释)
//009//CString              C字符串/转换成NSString编码问题
//000//EventDriven   事件驱动
    //000//CallBacks        回调汇总
    //016//HelperObjects    辅助对象/此时称辅助对象为委托对象,别的场景下称为数据源
    //000//KVO              键值观察(Cocoa bindings以及Core Data的关键组成部分)/继承关系中的KVO使用context进行验证
    //000//KVODependentProperties       KVO独立的属性
    //000//KVOExplicitlyNotification    KVO显式触发通知/willChangeValueForKey/didChangeValueForKey
    //000//KVORuntime       KVO工作原理
    //017//Notifications    通知/回调与对象所有权
    //014//NSRunLoop        运行循环/事件驱动
    //015//TargetAction     目标-动作对/选择器工作机制/@selector编译指令
//010//FileOperations       NSString/文件操作错误处理/UTF编码问题/特别目录
//000//IMP                  类的继承层次/IMP类型 (有错误未修正)
//000//KVC                  KVC/Key路径/Core Data的关键
//006//MemoryLeaks          强引用循环导致的内存泄漏
//001//ObjectiveC           日期与时间/字符串匹配
//003//ObjectOwnership      对象所有权与ARC
//000//Runtime                Objective-C运行时/自省/动态查找并执行方法/注册的类数量
//007//WeakReferences       父子对象之间的弱引用
//008//WeakReferencesZeroing 弱引用自动置零特性/__weak/手动引用计数与ARC历史/Retain计数规则/数组排序
