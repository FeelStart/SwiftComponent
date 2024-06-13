//
//  Test.cpp
//  MainC++
//
//  Created by Jingfu Li on 2024/6/7.
//

#include "Test.hpp"
#include <any>
#include <iostream>

void test(void) {
    std::cout<<"Begin test"<<std::endl;

    std::any v = 20UL;
    std::cout<<v.type().name()<<std::endl;

    // bad case
    try {
        auto v1 = std::any_cast<float>(v);
    } catch (const std::bad_any_cast& e) {
        std::cout<<e.what()<<std::endl;
    }
    // std::cout<<v1<<std::endl;

    std::any v2;
    if (v.has_value())
        std::cout<<"Have value"<<std::endl;
    v2 = 40;

    std::bitset<4> v3 {"0101"};

    std::cout<<"Begin end"<<std::endl;
}
