//
//  main.m
//  BlockImplementStatic
//
//  Created by 杨俊艺 on 2019/10/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int global_val = 1;
static int static_global_val = 2;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        static int static_val = 3;
        
        void (^blk) (void) = ^{
            global_val *= 10;
            static_global_val *= 2;
            static_val *= 3;
        };
        
        blk();
        
        printf("global_val = %d\nstatic_global_val = %d\nstatic_val = %d\n", global_val, static_global_val, static_val);
        
    }
    return 0;
}

//clang -rewrite-objc 源代码文件
//
//int global_val = 1;
//static int static_global_val = 2;
//
//Block对象的对象描述信息,相当于描述成Objective-C对象
//struct __block_impl {
//  void *isa;
//  int Flags;          标志位
//  int Reserved;       版本升级保留区(暂时不用)
//  void *FuncPtr;      函数指针
//};
//
//生成Block的结构体模版
//struct __main_block_impl_0 {
//           struct __block_impl impl;
//           struct __main_block_desc_0* Desc;              //自身描述信息结构体
//           int *static_val;                               //添加指向静态局部变量的指针类型的成员变量
//
//           //结构体构造函数,添加对指向静态局部变量的指针类型的成员变量的初始化
//           __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int *_static_val, int flags=0) : static_val(_static_val) {
//                                   impl.isa = &_NSConcreteStackBlock;
//                                   impl.Flags = flags;
//                                   impl.FuncPtr = fp;
//
//                                   Desc = desc;
//  }
//};
//
//生成的Block的描述信息结构体
//    保留区
//    Block的大小
//static struct __main_block_desc_0 {
//            size_t reserved;
//            size_t Block_size;
//} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
//
//
//要执行的目标函数
//static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
//            int *static_val = __cself->static_val; // bound by copy
//            global_val *= 10;
//            static_global_val *= 2;
//            (*static_val) *= 3;
//}
//
//
//int main(int argc, const char * argv[]) {
//    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
//
//        static int static_val = 3;
//
//构造Block类型对象,传入要执行的目标函数的地址,flags默认参数为0,且传入静态局部变量的地址给构造函数
//        void (*blk) (void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, &static_val));
//
//获得Block对象的成员FuncPtr并将FuncPtr强制转换成(void  (*) (__block_impl *)类型的函数指针并将自身作为参数进行调用
//        ((void (*)(__block_impl *))((__block_impl *)blk)->FuncPtr)((__block_impl *)blk);
//
//        printf("global_val = %d\nstatic_global_val = %d\nstatic_val = %d\n", global_val, static_global_val, static_val);
//
//    }
//    return 0;
//}
//
//static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };
