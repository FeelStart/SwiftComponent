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

template <typename T, bool Nullable = false>
using RelativeIndirectablePointer = int32_t;

struct Logger {
    RelativeIndirectablePointer<int, false> kind;
};

int main(int argc, const char * argv[]) {
    auto p = People { 1, 20, 30 };
    auto k = p.kind;
    auto r = p.duration;
    auto a = p.age;
    auto logger = Logger { 1 };

    std::cout<<sizeof(logger)<<std::endl;

    return 0;
}
