//
//  main.cpp
//  MainC++
//
//  Created by Jingfu Li on 2024/4/24.
//

#include <iostream>
#include "Header.h"

int main(int argc, const char * argv[]) {
    auto r0 = Z::max(20, 10);
    std::cout<<r0<<std::endl;

    auto a0 = Z::Array<int>();
    a0.addObject(10);
    a0.addObject(20);
    auto v0 = a0.objectAtIndex(1);

    return 0;
}
