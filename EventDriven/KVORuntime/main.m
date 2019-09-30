//
//  main.m
//  KVORuntime
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRTowel.h"
#import <objc/message.h>
#import <objc/runtime.h>

NSArray *BNRHierarchyForClass(Class cls)
{
    NSMutableArray *classHierarchy = [NSMutableArray array];    //用来保存类及其父类组成的列表,创建一个层级
    
    for (Class c = cls; c != nil; c = class_getSuperclass(c)) { //继续追踪继承层级直到再也没有父类,通常最后的类是NSObject
        NSString *className = NSStringFromClass(c);
        [classHierarchy insertObject:className atIndex:0];
    }
    return classHierarchy;
}

NSArray *BNRMethodsForClass(Class cls)
{
    unsigned int methodCount = 0;                                 //用来保存注册的类的数量
    Method *methodList = class_copyMethodList(cls, &methodCount);
    
    NSMutableArray *methodArray = [NSMutableArray array];
    
    for (int i = 0; i < methodCount; i++) {
        Method currentMethod = methodList[i];                           //获取当前的方法
        
        SEL methodSelector = method_getName(currentMethod);             //获取当前方法的选择器
        [methodArray addObject:NSStringFromSelector(methodSelector)];   //给数组增加字符串表示形式
    }
    return methodArray;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRTowel *myTowel = [BNRTowel new];
        [myTowel addObserver:nil forKeyPath:@"location" options:NSKeyValueObservingOptionNew context:NULL];//然后给BNRTowel实例增加一个nil KVO观察者
        
        
        
        
        
        NSMutableArray *runtimeClassInfo = [NSMutableArray array];//字典数组,每个数组都会保存类的名称,层级以及给定类的方法列表
        
                                                                //Objective-C运行时不仅负责记录正在使用哪些类,还负责记录那些包含到程序中的库以及框架使用的类
        unsigned int classCount = 0;                            //用来保存注册的类的数量
        Class *classList = objc_copyClassList(&classCount);     //返回的指针指向当前加载的所有注册类的列表,通过引用返回注册类的数量,objc_copyClassList会返回一个由指向类对象指针组成的C数组
        
        for (int i = 0; i < classCount; i++) {                      //列出表单中的每一个类
            Class currentClass = classList[i];                          //将类的列表当成C数组进行处理
            
            NSString *className = NSStringFromClass(currentClass);      //获得当前类的类名
            
            NSArray *hierarchy = BNRHierarchyForClass(currentClass);    //获得当前类的继承层级列表
            
            NSArray *methods = BNRMethodsForClass(currentClass);        //获得当前类的方法列表
            
            NSDictionary *classInfoDict = @{@"classname" : className,
                                            @"hierarchy" : hierarchy,
                                            @"methods"   : methods};
            
            [runtimeClassInfo addObject:classInfoDict];             //将当前类的所有信息放入字典数组中
        }
        
        free(classList);                                            //释放类列表缓冲区
        
        //按字母顺序排序
        NSSortDescriptor *alphaAsc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        NSArray *sortedArray = [runtimeClassInfo sortedArrayUsingDescriptors:@[alphaAsc]];
        
        NSLog(@"There are %ld classes registered with this program's Runtime.", sortedArray.count);
        
        NSLog(@"%@", sortedArray);
        
    }
    return 0;
}

//键值观察KVO是苹果公司API依赖于运行时的另一个例子,在讨论KVO时,如果使用对象存取器,被观察的对象可以自动通知属性中的变化
//运行时,如果向某个对象发送addObserver:forKeyPath:options:context:消息,那么这个方法可以:
//  决定被观察对象的类,并使用objc_allocateClassPair()函数为这个类定义一个新的子类
//  改变对象的isa指针,让其指向新的子类(高效改变对象的类型)
//  覆盖被观察对象的存取器,发送KVO消息
//
//                      KVO动态子类
//                                                   ----------------
//                                                  |    BNRTowel    |
//                                                   ----------------
//                                                  |                |
//                                                   ----------------
//                                                  |   setLocation  |
//                                                   ----------------
//                                                          /|\
//                                                           |
//                                                         继承自
//         ____________                                      |
//        |  BNRTowel  |                                     |
//        |____________|-----------isa----------->-----------------------
//        |  location  |                         |NSKVONotifying_BNRTowel|
//        |____________|                          -----------------------
//              |                                |                       |
//              |                                 -----------------------
//              |                                |      setLocation      |
//              |                                 -----------------------
//             \|/
//         ____________
//        |SomeObserver|
//        |____________|
//        |            |
//        |____________|
//
//
//例如一个类的location属性的存方法代码如下:
//
//- (void) setLocation:(NSPoint)location
//{
//    _location = location;
//}
//
//在新的子类中存取器会被覆盖成:
//
//- (void) setLocation:(NSPoint)location
//{
//    [self willChangeValueForKey:@"location"];
//    [super setLocation:location];
//    [self didChangeValueForKey:@"location"];
//}
//
//子类存取器实现会调用原始类的实现,然后将它们用简明的KVO通知消息封装起来,这些新的类以及方法都会在运行时使用Objective-C运行时函数定义
//
//现在要让子类工作了,添加一个新类BNRTowel并创建一个属性location
//构建并运行程序,在输出中可以搜索到Towel,尽管没有进行实例化或实现任何方法,输出还是增加了内容
//
//{
//    classname = BNRTowel;
//    hierarchy =         (
//        NSObject,
//        BNRTowel
//    );
//    methods =         (
//        location,
//        "setLocation:"
//    );
//}
//
//然后给BNRTowel实例增加一个nil KVO观察者
//构建并运行程序,再次搜索Towel,这次除了BNRTowel类,还可以在列表中看到一个新的子类
//
//{
//    classname = "NSKVONotifying_BNRTowel";
//    hierarchy =         (
//        NSObject,
//        BNRTowel,
//        "NSKVONotifying_BNRTowel"
//    );
//    methods =         (
//        "setLocation:",
//        class,
//        dealloc,
//        "_isKVOA"
//    );
//}
