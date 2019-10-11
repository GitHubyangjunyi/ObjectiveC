//
//  main.m
//  BlockImplementBlockPre
//
//  Created by 杨俊艺 on 2019/10/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int dmy = 256;
        int val = 10;
        const char *fmt = "val = %d\n";
        
        void (^blk) (void) = ^{printf(fmt, val);};
        
        blk();
        
        val = 2;
        
        fmt = "These values were changed. val = %d\n";
        
        blk();
        
        printf(fmt, val);
        
        
    }
    return 0;
}

//clang -rewrite-objc 源代码文件
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
//            struct __block_impl impl;
//            struct __main_block_desc_0* Desc;              //自身描述信息结构体
//            const char *fmt;                              //底层const,不允许通过fmt改变字符串内容
//            int val;                                      //成员变量捕获瞬时值
//
//结构体构造函数,添加对指向静态局部变量的指针类型的成员变量的初始化
//            __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, const char *_fmt, int _val, int flags=0) : fmt(_fmt), val(_val) {
//                                   impl.isa = &_NSConcreteStackBlock;           //获得类型信息
//                                   impl.Flags = flags;                          //获得标志
//                                   impl.FuncPtr = fp;                           //获得函数指针
//
//                                       Desc = desc;                             //获得自身描述信息,包括保留区,自身大小
//  }
//};
//
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
//                      const char *fmt = __cself->fmt; // bound by copy
//                      int val = __cself->val;         // bound by copy
//            printf(fmt, val);
//}
//
//
//int main(int argc, const char * argv[]) {
//    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
//
//        int dmy = 256;
//        int val = 10;
//        const char *fmt = "val = %d\n";
//
//        void (*blk) (void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, fmt, val));
//
//        ((void (*)(__block_impl *))((__block_impl *)blk)->FuncPtr)((__block_impl *)blk);
//
//        val = 2;
//        fmt = "These values were changed. val = %d\n";
//
//        ((void (*)(__block_impl *))((__block_impl *)blk)->FuncPtr)((__block_impl *)blk);
//
//        printf(fmt, val);
//
//
//    }
//    return 0;
//}
//static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };
