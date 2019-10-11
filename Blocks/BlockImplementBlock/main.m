//
//  main.m
//  BlockImplementBlock
//
//  Created by 杨俊艺 on 2019/10/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        __block int val = 1;
        
        void (^blk) (void) = ^{val = 2;};
        
        blk();
        
        printf("val = %d\n", val);
        
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
//           struct __block_impl impl;
//           struct __main_block_desc_0* Desc;
//           __Block_byref_val_0 *val;     // by ref
//
//           __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_val_0 *_val, int flags=0) : val(_val->__forwarding) {
//                                    impl.isa = &_NSConcreteStackBlock;              //自身描述信息结构体
//                                    impl.Flags = flags;                             //获得标志
//                                    impl.FuncPtr = fp;                              //获得函数指针
//
//                                    Desc = desc;                                    //获得自身描述信息,包括保留区,自身大小
//  }
//};
//
//生成的Block的描述信息结构体
//    保留区
//    Block的大小
//static struct __main_block_desc_0 {
//            size_t reserved;
//            size_t Block_size;
//            void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
//            void (*dispose)(struct __main_block_impl_0*);
//} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};
//
//
//
//struct __Block_byref_val_0 {
//           void *__isa;
//      __Block_byref_val_0 *__forwarding;    实现无论__block变量在栈上还是堆上都可以正确访问
//            int __flags;
//            int __size;
//            int val;
//};
//在栈上的__block变量用结构体实例在__block变量从栈上复制到堆上时,会将成员变量__forwarding的值替换为复制目标堆上的__block变量用结构体实例的地址
//在这之后使用val->__forwarding->val时,val都是指存放在堆上的那一个val结构体实例的成员变量val
//
//
//static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->val, (void*)src->val, 8/*BLOCK_FIELD_IS_BYREF*/);}
//
//static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->val, 8/*BLOCK_FIELD_IS_BYREF*/);}
//
//
//要执行的目标函数
//static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
//            __Block_byref_val_0 *val = __cself->val; // bound by ref
//       (val->__forwarding->val) = 2;
//}
//
//
//int main(int argc, const char * argv[]) {
//    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
//
//            //栈上生成的自动变量作为__block变量的结构体实例,并将__block结构体实例的isa设置为0,__forwarding指向自身,flags为0,并将瞬时初始值以值的形式保存
//        __attribute__((__blocks__(byref))) __Block_byref_val_0 val = {(void*)0,(__Block_byref_val_0 *)&val, 0, sizeof(__Block_byref_val_0), 1};
//
//
//            //flags标志不再为默认的0
//        void (*blk) (void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_val_0 *)&val, 570425344));
//
//
//        ((void (*)(__block_impl *))((__block_impl *)blk)->FuncPtr)((__block_impl *)blk);
//
//
//        printf("val = %d\n", (val.__forwarding->val));
//
//    }
//    return 0;
//}
