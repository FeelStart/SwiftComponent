//
//  main.cpp
//  MainC++
//
//  Created by Jingfu Li on 2024/4/24.
//

#include <iostream>

struct Base {
    int kind;
};

struct Run {
    long duration;
};

struct People: Base, Run {
    int age;
};

int main(int argc, const char * argv[]) {
    auto p = People { 1, 20, 30 };
    auto k = p.kind;
    auto r = p.duration;
    auto a = p.age;

    std::cout<<sizeof(p)<<std::endl;

    return 0;
}
