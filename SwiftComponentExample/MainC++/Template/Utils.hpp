//
//  Utils.hpp
//  MainC++
//
//  Created by Jingfu Li on 2024/4/25.
//

#ifndef Utils_hpp
#define Utils_hpp

#include <stdio.h>

namespace Z {

template<class T>
T max(T a, T b) {
    return a < b ? b : a;
}

template<class T>
T min(T a, T b) {
    return a < b ? a : b;
}

template<class T, int size = 10>
class Array {
public:
    Array() {
        m_length = 0;
        m_mem = malloc(size);
    }

    void addObject(T object) {
    }
    
private:
    void *m_mem;
    int m_length;
};

}

#endif /* Utils_hpp */
