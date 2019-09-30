//
//  main.m
//  IMP
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
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

//输出内容就会包含类的名称,继承层级以及程序运行时所有注册类的方法列表
//方法类型
//方法是一类结构的名字,结构成员包括方法的选择器(SEL类型的变量)以及一个函数指针,这个函数指针是IMP类型的变量
