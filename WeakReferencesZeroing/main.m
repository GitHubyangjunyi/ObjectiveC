//
//  main.m
//  WeakReferencesZeroing
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNREmployee.h"
#import "BNRAsset.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //创建一个数组用来包含多个BNREmployee对象
        NSMutableArray *employees = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 10; i++) {
            BNREmployee *mikey = [[BNREmployee alloc] init];
            
            mikey.weightInKilos = 90 + i;
            mikey.heightInMeters = 1.8 - i / 10.0;
            mikey.employeeID = i;
            [employees addObject:mikey];
        }
        
        //
        NSMutableArray *allAssets = [[NSMutableArray alloc] init];
        //
        
        
        //创建10个BNRAsset对象
        for (int i = 0; i < 10; i++) {
            BNRAsset *asset = [[BNRAsset alloc] init];
            
            //为BNRAsset设置合适的标签
            NSString *currentLabel = [NSString stringWithFormat:@"Latop %d", i];
            asset.label = currentLabel;
            asset.resaleValue = 350 + i * 10;
            
            //生成0到9之间的随机数
            NSUInteger randomIndex = random() % [employees count];
            NSLog(@"randomIndex: %lu", (unsigned long)randomIndex);
            //取出相应的BNREmployee对象
            BNREmployee *randomEmployee = [employees objectAtIndex:randomIndex];
            
            //将BNRAsset对象赋给该BNREmployee对象
            [randomEmployee addAssets:asset];
            
            
            //
            [allAssets addObject:asset];
            //
        }
        
        //这里插入数组排序
//        NSSortDescriptor *voa = [NSSortDescriptor sortDescriptorWithKey:@"valueOfAssets" ascending:YES];//创建第一排序对象
//        NSSortDescriptor *eid = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];//创建第二排序对象
//        [employees sortUsingDescriptors:@[voa, eid]];
        //该方法的实参是一个包含NSSortDescriptor对象的数组对象,排序描述对象包含两个信息,一是数组中对象的属性名,二是根据该属性选择升序还是降序
        
        
        //这里插入过滤
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"holder.valueOfAssets > 70"];
//        NSArray *toBeReclaimed = [allAssets filterUsingPredicate:predicate];
//        NSLog(@"toBeReclaimed: %@", toBeReclaimed);
//        toBeReclaimed = nil;
        
        NSLog(@"Employees: %@", employees);
        
        NSLog(@"Giving up ownership of one employee");
        [employees removeObjectAtIndex:5];
        
        
        //
        NSLog(@"allAssets: %@", allAssets);
        //
        
        
        NSLog(@"Giving up ownership of arrays");
        
        //
        allAssets = nil;
        //
        
        employees = nil;
    }
    return 0;
}

//如果对象间是父子关系,那么为了避免强引用循环通常需要遵守此规则:
//父对象拥有子对象,但是子对象不拥有父对象
//
//加入一个新的数组以说明弱引用
//如果要让一个数组包含所有的BNRAsset对象(包括holder属性为空的对象),则可以在创建BNRAsset对象时将新创建的对象都加入这个数组对象
//
//程序运行结果
//当索引为5的BNREmployee对象被释放时,控制台会输出allAssets的全部内容
//这些BNRAsset对象虽然会失去一个拥有方BNREmployee 5#,但是还会有另一个拥有方allAssets,所以不会被释放
//但是这些对象的holder实例变量被置为nil,因为当某个由弱引用指向的对象被释放时,相应的指针归为nil
//总结就是强引用会保留对象的拥有方,使其不被释放
//弱引用则不会保留,因此标为弱引用的实例变量与属性指向的对象可能会消失
//如果发生了这种情况则实例变量或者属性会被设置为nil,而不是继续指向曾经指向的对象
//
//如果需要明确地将指针变量声明为弱引用,可以标注__weak
__weak BNRPerson *parent;
//
//
//深入学习手动引用计数与ARC历史/Retain计数规则
//
//在Objective-C加入ARC之前程序员必须手动引用计数维护retain计数
//使用手动引用计数时,只有当程序员显式地向对象发送能够增加或者减少retain计数的消息时,相应对象的所有权才会发生变化
//  [object release]  //object失去一个拥有方
//  [object retain]   //object得到一个拥有方
//这段代码所使用的release方法和ratain方法通常会在存取方法和dealloc方法中使用
//  在存方法中程序应该保留新值释放旧值
//  在dealloc方法中程序应该释放所有之前保留过的对象
//使用手动引用计数改写BNRAsset类的setHolder:方法
//-(void)setHolder:(BNREmployee *)newEmployee
//{
//                          //获取新holder的拥有权
//    [newEmployee retain];
//                          //释放旧holder的拥有权
//    [holder release];
//                          //让指针指向新的holder
//    holder = newEmployee;
//}
//
//改写dealloc法方法
//-(void)dealloc
//{
//                      //放弃曾经拥有的所有对象的拥有权
//    [label release];
//    [holder release];
//    [super release];
//}
//
//那么description方法呢?该方法创建并返回一个字符串,BNRAsset对象是否需要保留该对象呢?答案是不需要保留
//
//-(NSString *)description
//{
//    if (self.holder) {
//        return [NSString stringWithFormat:@"<%@: $%d, assigned to %@>", self.label, self.resaleValue, self.holder];
//    } else {
//        return [NSString stringWithFormat:@"<%@: $%u unassigned>", self.label, self.resaleValue];
//    }
//}
//
//因为description方法返回的是autorelease过的字符串,当某个对象收到autorelease消息时,它会在将来某个时刻收到release消息
//如果不使用ARC,那么description方法如下
//
//-(NSString *)description
//{
//    NSString *result = [[NSString alloc] initWithFormat:@"<%@: $%u>", [self.label], [self.resaleValue]];
//    [result autorelease];
//    return result;
//}
//
//description方法所返回的NSString对象会在什么时候收到release消息?答案是当autorelease池(对象)被排干的时候,代码如下
//创建autorelease池
//  NSAutoreleasePool *arp = [[NSAutoreleasePool alloc] init];
//  BNRAsset *asset = [[BNRAsset alloc] init];
//  NSString *s = [asset description];
//      s指向的NSString对象已经在autorelease池中
//  NSLog(@"The asset is %@", s);
//
//  [arp drain];//description方法所返回的NSString对象会收到release消息
//
//
//虽然ARC会自动使用autorelease池,但是必须有程序创建并排空相应的autorelease池
//Objective-C加入ARC时也加入了用于创建autorelease池的新语法,用新语法改写
//创建autorelease池
//@autoreleasepool {
//  BNRAsset *asset = [[BNRAsset alloc] init];
//  NSString *s = [asset description];
//      s指向的NSString对象已经在autorelease池中
//}//autorelease池已经被排空
//
//
//Retain计数规则
//下面为若干规则,规则中的你代表当前正在使用的某个类实例
//1.如果用来创建对象的方法,其方法名是以alloc/new开头的,或者包含copy,那么你已经得到了该对象的所有权,既可以假设新对象的retain是1,而且该对象不在NSAutoreleasePool池中
//你要负责在不需要该对象时释放之,以下是部分会传输所有权的方法:alloc(后面总是跟着init方法)/copy/mutableCopy
//2.通过任何其他途径创建的对象,如通过便捷方法,你是没有所有权的,既可以假设新对象的retain是1,而且该对象已经在NSAutoreleasePool对象中,如果没有保留该对象,那么当NSAutoreleasePool对象被排干时这个对象就会被释放
//3.如果你不拥有某个对象,但是要确保该对象能够继续存在,可以通过向其发送retain消息
//release消息会使得retain立刻减1,而autorelease会导致当NSAutoreleasePool对象被排干时,再向相应的对象发送release消息
//4.只要对象还有至少一个拥有方,该对象就会继续存在下去,当该对象的retain计数到达0时就会收到dealloc消息
//
//从所有权角度考虑问题就能很容易解释为什么需要在description方法中向返回的字符串发送autorelease消息
//因为BNREmployee对象创建了一个NSString对象,但是不想拥有该对象,而只是为了返回一个结果将其"交"出去而已
