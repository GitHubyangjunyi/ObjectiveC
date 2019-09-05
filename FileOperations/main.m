//
//  main.m
//  FileOperations
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableString *wstr = [[NSMutableString alloc] init];
        for (int i = 0; i < 10; i++) {
            [wstr appendString:@"Aaron is cool!\n"];
        }
        
        NSError *error;//并没有创建相应的NSError对象,为了避免没有错误发生的时候创建不必要的对象,如果在执行的时候发生了错误则该方法会创建一个新的NSError实例并修改传入的指针指向新实例
        BOOL success = [wstr writeToFile:@"~/Desktop/cool.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];//从本质上讲这里传入的是地址的地址
        if (success) {
            NSLog(@"done write cool.txt");
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        
        NSMutableString *rstr = [[NSString alloc] initWithContentsOfFile:@"cool.txt" encoding:NSASCIIStringEncoding error:&error];
        if (!rstr) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            NSLog(@"%@", rstr);
        }
        
        
        //将NSData对象所保存的数据写入文件,NSData对象代表内存中某块缓冲区
        //从网上下载照片
        NSURL *url = [NSURL URLWithString:@"https://i1.mifile.cn/f/i/19/zlc28v/index_interface_item3.jpg"];//小米官网某张图片
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSError *urlerror = nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&urlerror];
        //以上这行代码会阻塞程序直到下载完全部数据
        
        if (!data) {
            NSLog(@"fetch failed: %@", [urlerror localizedDescription]);
            return 1;
        }
        NSLog(@"The file is %lu bytes", (unsigned long)[data length]);
        
        BOOL written = [data writeToFile:@"x.jpg" options:NSDataWritingAtomic error:&urlerror];//使用原子写操作,NSData对象会先将数据写入临时文件,成功后再移动到指定的路径
        
        if (!written) {
            NSLog(@"write failed: %@", [urlerror localizedDescription]);
            return 2;
        }
        NSLog(@"Success!");
        
        //从文件读取数据并存入NSData对象
        NSData *readData = [NSData dataWithContentsOfFile:@"x.jpg"];
        NSLog(@"The file read from the disk has %lu bytes", (unsigned long)[readData length]);
        
        //特别目录
        //苹果公司创建了一个函数用来告诉正确的目录
        NSArray *desktops = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
        NSString *desktopPath = desktops[0];
        NSLog(@"%@", desktopPath);
        
    }
    return 0;
}

//在将字符串对象写入文件时需要指定字符串编码格式,字符串编码的作用是描述字符和代表字符的数字之间的映射关系
//在ASCII中,字符A对应0100 0001,在UTF-16中字符A对应00000000 0100 0001
//在UTF-16中一个字符将占用两个或更多字节,在UTF-8中,ASCII字符集中的前128个字符将占用一个字节,其他字符占用两个或者更多字节
//

//
//
//
//
//
