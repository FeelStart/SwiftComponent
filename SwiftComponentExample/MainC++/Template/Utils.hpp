//
//  Utils.hpp
//  MainC++
//
//  Created by Jingfu Li on 2024/4/25.
//

#ifndef Utils_hpp
#define Utils_hpp

#include <stdio.h>
#include <stdlib.h>
#include <type_traits>

namespace Z {

template<typename T, typename U>
struct is_same: std::false_type  {};

template<typename T>
struct is_same<T, T>: std::true_type {};

template< class T, class U >
inline constexpr bool is_same_v = is_same<T, U>::value;

template<typename T> concept NotIntT = sizeof(T) != sizeof(int);

template<typename T> concept addable = requires (T a, T b) {
    a + b;
};

template<typename T>
struct Tpye {
};

template<>
struct Tpye<int> {
};

template<typename T>
auto sum(T a, T b) requires addable<T> {
    return a + b;
};

template<NotIntT T>
struct NotInt {
private:
    T value;
public:
    NotInt<T>(T value): value(value) {};
};

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
        m_mem = (T *)malloc(size * sizeof(T));
        m_length = 0;
    }

    void addObject(T object) {
        if (m_length >= size) {
            return;
        }

        m_mem[m_length++] = object;
    }

    T objectAtIndex(int index) {
        return m_mem[index];
    }

private:
    T *m_mem;
    int m_length;
};

}

#endif /* Utils_hpp */
