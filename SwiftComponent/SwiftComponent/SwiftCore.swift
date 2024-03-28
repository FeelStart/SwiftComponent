//
//  SwiftCore.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/3/19.
//

import Foundation

public enum SwiftCore {
}

/// swift/public/swiftshims/swift/shims/HeapObject.h
extension SwiftCore {
    public struct HeadObject {
        let metadata: HeapMetadata
        let refCounts: Int
    }
}

/// swift/include/swift/ABI/Metadata.h
extension SwiftCore {
    public class TargetMetadata<Runtime> {
        var kind: MetadataKind = .unknown
    }

    public typealias HeapMetadata = TargetHeapMetadata<InProcess>

    public class TargetHeapMetadata<Runtime>: TargetMetadata<Runtime> {
    }

    public typealias ValueMetadata = TargetValueMetadata<InProcess>

    /// commom for struct or enum
    public class TargetValueMetadata<Runtime>: TargetMetadata<Runtime> {
        var description: TargetValueTypeDescriptor<Runtime>?
    }

    // MARK: -

    public class TargetContextDescriptor<Runtime> {
        var flags: UInt32 = 0
        var parent: Any?
        /// name of type
        var name: String = ""
    }

    public class TargetTypeContextDescriptor<Runtime>: TargetContextDescriptor<Runtime> {
    }

    public class TargetValueTypeDescriptor<Runtime>: TargetTypeContextDescriptor<Runtime> {
    }

    public class TargetStructDescriptor<Runtime>: TargetValueTypeDescriptor<Runtime> {
        /// 属性数目
        var numFields: UInt32 = 0
        var fieldOffsetVectorOffset: UInt32 = 0
    }
}

/// swift/include/swift/ABI/MetadataValues.h
/// swift/include/swift/ABI/MetadataKind.def
extension SwiftCore {
    public enum MetadataKind: UInt {
        case Class = 0
        case Struct = 0x200
        case Enum = 0x201
        case Optional = 0x202
        case ForeignClass = 0x203
        case ForeignReferenceType = 0x204
        case Opaque = 0x300
        case Tuple = 0x301
        case Function = 0x302
        case Existential = 0x303
        case Metatype = 0x304
        case ObjCClassWrapper = 0x305
        case ExistentialMetatype = 0x306
        case ExtendedExistential = 0x307
        case HeapLocalVariable = 0x400
        case HeapGenericLocalVariable = 0x500
        case ErrorObject = 0x501
        case Task = 0x502
        case Job = 0x503
        case unknown
    }
}

/// swift/include/swift/ABI/TargetLayout.h
extension SwiftCore {
    public struct InProcess {
    }
}
