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
        
        NSURL *url = [NSURL URLWithString:@"http://www.gutenberg.org/cache/epub/205/pg205.txt"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        __unused NSURLConnection *fetchConn = [[NSURLConnection alloc] initWithRequest:request delegate:logger startImmediately:YES];   //设置logger为委托对象
        
        
        [[NSRunLoop currentRunLoop] run];
        
        
        //NSRunLoop---->NSURLConnection----委托对象---->BNRLogger
        //                   |                          委托方法(实现<NSURLConnectionDelegate, NSURLConnectionDataDelegate>协议)
        //                  请求                     -(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;//收到一定字节数的数据时会被调用
        //                   |                      -(void)connectionDidFinishLoading:(NSURLConnection *)connection;//最后一部分数据处理完毕后会被调用
        //                   |                      -(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;//获取数据失败时会被调用
        //                  \|/
        //              NSURLRequest
        //                   |
        //                   |
        //                  \|/
        //                 NSURL
        //
        //
        //                                          BNRLogger对象是NSURLConnection对象的委托对象,当特定的事件发生时,该对象会向辅助对象发送相应的消息,具体哪些消息由协议规定
        
        
        
    }
    return 0;
}

//前面的FileOperations项目从网站获取图片,数据传输是需要同步的,也就是说所有的数据必须一次传输成功,这导致两个问题
//1.获取数据时会阻塞主线程,如果在正式的应用中使用该方法,那么在获取数据时,用户界面将失去响应
//2.某些情况下无法实现回调,当服务器要求提供用户名和密码时程序无法通过回调来提供信息
//如果没有设置回调,服务器需要你的认证信息才会把数据发给你,而你一直在等服务器给你发数据,其他啥都不干,服务器也一直等你给它发认证信息过去,导致双方相互等待
//
//鉴于以上原因,通常会以异步方式来使用NSURLConnection
//在异步模式下NSURLConnection不会一次发送全部数据,而是发送块状数据,并多次发送
//也就是说需要有传输相关的事件,且程序要准备好响应这个事件
//相关的事件有:得到数据/服务器要求提供认证信息/获取数据失败等
//
//为了实现更复杂的传输,要使用一个异步的NSURLConnection实例来从网上抓取数据
//BNRLogger的实例将会成为NSURLConnection的辅助对象,更确切说是,BNRLogger对象会成为NSURLConnection的委托对象
//当特定的事件发生时,该对象会向辅助对象发送相应的消息,具体是哪些消息?
//苹果公司为NSURLConnection提供了一套协议,协议是一系列方法声明,辅助对象可以根据协议实现相应的方法
//
//作为NSURLConnection的委托对象,BNRLogger需要响应三条消息,其中两条来自NSURLConnectionDataDelegate协议
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;    //收到一定字节数的数据时会被调用
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection;                  //最后一部分数据处理完毕后会被调用

//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;//获取数据失败时会被调用
//
//构建并运行程序,应该能陆续收到服务器发来的数据,最后当获取数据结束时,委托对象会收到相应的消息
//目前的回调规则如下
//当要向一个对象发送一个回调时,苹果公司会使用目标-动作对
//当要向一个对象发送多个回调时,苹果公司会使用符合相应协议的辅助对象,根据用途,辅助对象常称为委托或者数据源
//
//接下来的问题是如何处理要发送给多个对象的回调?
