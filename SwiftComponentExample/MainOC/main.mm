//
//  main.m
//  MainOC
//
//  Created by Jingfu Li on 2024/5/8.
//

#import <Foundation/Foundation.h>
#import "Runtime.h"

@interface People : NSObject {
@public
    int _age;
}

- (void)log;

@end

@implementation People

- (void)log {
    NSLog(@"log\n");
}

@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        typedef struct {
            int age;
        } Man;

        People *p = [People new];
        p->_age = 22;
        auto age = p->_age;

        auto c0 = (__bridge z_objc_object *)(p);
        auto c1 = (__bridge z_objc_class *)(c0->isa);

        for (int i = 0; i < 100; i++) {
            auto m = calloc(1, sizeof(Man));
            //NSLog(@"%p\n", m);
        }

        {
            auto m0 = @"A";
            auto m1 = @"B";
            auto m2 = @"C";
            auto m3 = [NSNumber numberWithInt:3];
            auto m4 = [NSNumber numberWithInt:4];
            auto m5 = [NSNumber numberWithInt:5];
            auto m6 = [NSNumber numberWithInt:6];
            auto m7 = [NSNumber numberWithInt:7];

        }

    }

    return 0;
}
