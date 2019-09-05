//
//  main.m
//  HelperObjects
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRLogger.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRLogger *logger = [[BNRLogger alloc] init];
        
        //注册成为观察者使之在时区设置发生变化时收到通知
        [[NSNotificationCenter defaultCenter] addObserver:logger selector:@selector(zoneChange:) name:NSSystemTimeZoneDidChangeNotification object:nil];
        
        NSURL *url = [NSURL URLWithString:@"http://www.gutenberg.org/cache/epub/205/pg205.txt"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        __unused NSURLConnection *fetchConn = [[NSURLConnection alloc] initWithRequest:request delegate:logger startImmediately:YES];
        
        __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:logger selector:@selector(updateLastTime:) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] run];
        
        
        //NSRunLoop---->NSURLConnection----委托方法---->BNRLogger
        //                  请求                     -(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;//收到一定字节数的数据时会被调用
        //                   |                      -(void)connectionDidFinishLoading:(NSURLConnection *)connection;//最后一部分数据处理完毕后会被调用
        //                   |                      -(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;//获取数据失败时会被调用
        //                  \|/
        //              NSURLRequest
        
        //BNRLogger对象是NSURLConnection对象的委托对象
        
        
    }
    return 0;
}

//
//前面的从网站获取图片,数据传输是需要同步的,也就是说所有的数据必须一次传输成功,这导致两个问题
//1.获取数据时会阻塞主线程,如果在正式的应用中使用该方法,那么在获取数据时,用户界面将失去响应
//2.某些情况下无法实现回调,当服务器要求提供用户名和密码时程序无法通过回调来提供信息
//
//鉴于以上原因,通常会以异步方式来使用NSURLConnection
//在异步模式下NSURLConnection不会一次发送全部数据,而是发送块状数据,并多次发送
//也就是说需要有传输相关的事件,且程序要准备好响应这个事件
//相关的事件有:得到数据/服务器要求提供认证信息/获取数据失败等
//
//为了实现更复杂的传输,要使用一个异步的NSURLConnection实例来从网上抓取数据
//BNRLogger的实例将会成为NSURLConnection的辅助对象,更确切说是,BNRLogger对象会成为NSURLConnection的委托对象
//当特定的事件发生时,该对象会向扶助对象发送相应的消息,具体是哪些消息?
//苹果公司为NSURLConnection提供了一套协议,协议是一系列方法声明,辅助对象可以根据协议实现相应的方法
//
//作为NSURLConnection的委托对象,BNRLogger需要响应三条消息,其中两条来自NSURLConnectionDataDelegate协议
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;//收到一定字节数的数据时会被调用
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection;//最后一部分数据处理完毕后会被调用

//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;//获取数据失败时会被调用
//
//构建并运行程序,应该能陆续收到服务器发来的数据,最后当获取数据结束时,委托对象会收到相应的消息
//
//目前的毁掉规则如下
//当要向一个对象发送一个回调时,苹果公司会使用目标-动作对
//当要向一个对象发送多个回调时,苹果公司会使用符合相应协议的扶助对象,根据用途,辅助对象常称为委托或者数据源
//
//接下来的问题是如何处理要发送给多个对象的回调?
//当用户修改了系统时区设置时,程序中的很多对象可能需要知道这一变化,这些对象都可以通过通知中心将自己注册成为观察者observer
//当系统时区设置变化时会向通知中心发布NSSystemTimeZoneDidChangeNotification通知,然后通知中心会将该通知转发给相应的观察者
//在向通知中心注册观察者时可以指定某个特定的通知名以及通知发布的来源,这两个参数都可以设置为nil,如果都设置为nil那么就会接收到程序中所有对象发布的每条通知
//
//关于如何选择?
//1.对于只做一件事的对象,例如NSTimer,选择目标-动作对
//2.对于复杂功能使用辅助对象
//3.对于要触发多个(其他对象中的)回调的对象,使用通知
//
//回调与对象所有权
//无论哪种类型的回调,如果代码不正确则有陷入强循环引用的风险
//常常发生这种情况:
//  创建的对象有个指向回调对象的指针,而这个回调对象的指针指向你创建的对象
//所以在编写代码时遵守以下规则:
//1.通知中心不拥有观察者,如果将某个对象注册为观察者,通常应该在释放该对象时将其移除通知中心
//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//2.对象不拥有委托对象或数据源对象,如果某个新创建的对象是另一个对象的委托对象或数据源对象,那么该对象应该在其dealloc方法中取消相应关联
//-(void)dealloc
//{
//    [windowThatBossesMeAround setDelegate:nil];
//    [tableViewThatBegsForData setDataSource:nil];
//}
//
//3.对象不拥有目标,如果某个新创建的对象是另一个对象的目标,那么该对象应该在其dealloc方法中将相应的目标指针赋为nil
//-(void)dealloc
//{
//    [buttonThatKeepsSendingMeMessages setTarget:nil];
//}
//
//因为BNRLogger对象不会在程序终止前被释放,所以不存在以上问题,非常侥幸的是程序碰巧使用了两个例外情况
//NSURLConnection对象会保留其委托对象
//NSTimer会保留其目标
//
//选择器工作机制
//方法查询d非常快速,如果使用方法的实际名称(可能很长)进行查询,那么查询速度会很慢,为了提速,编译器会为每个其接触过的方法附上一个唯一数字,运行时程序使用这个数字而不是方法名
//代表特定方法名的唯一数字称为选择器,当一个方法需要一个选择器作为实参,实际上需要的就是数字,通过编译指令@selector可以得到与方法名相对应的选择器
