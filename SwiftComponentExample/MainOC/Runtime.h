//
//  Runtime.h
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/5/8.
//

#ifndef Runtime_h
#define Runtime_h

typedef struct {
    Class isa;
} z_objc_object;

typedef struct {
    Class isa;
    Class super_class;
    const char *name;
    long version;
    long info;
    long instance_size;
    struct objc_ivar_list *ivars;
    struct objc_method_list **methodLists;
    struct objc_cache *cache;
    struct objc_protocol_list *protocols;
} z_objc_class;


#endif /* Runtime_h */
