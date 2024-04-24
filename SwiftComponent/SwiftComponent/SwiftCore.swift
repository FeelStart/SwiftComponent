//
//  SwiftCore.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/3/19.
//

import Foundation

/// swift/include/swift/ABI/MetadataValues.h
/// swift/include/swift/ABI/MetadataKind.def
public enum CoreMetadataKind: UInt {
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

public struct CoreStructMetadata {
    public let kind: UInt
    public let descriptor: UnsafePointer<CoreTargetStructDescriptor>

    public func coreMetadataKind() -> CoreMetadataKind {
        CoreMetadataKind(rawValue: kind) ?? .unknown
    }
}

public struct CoreTargetStructDescriptor {
    let NumFields: UInt32
    let FieldOffsetVectorOffset: UInt32
}

/*
public enum SwiftCore {
}

// MARK: - HeadObject
/// swift/public/swiftshims/swift/shims/HeapObject.h
extension SwiftCore {
    public struct HeadObject {
        public let metadata: HeapMetadata
        public let refCounts: UInt
    }
}

// MARK: - Metadata
/// swift/include/swift/ABI/Metadata.h
extension SwiftCore {
    public struct TargetMetadata<Runtime> {
        public var kind: MetadataKind = .unknown
    }
}

// MARK: - HeadMetadata
extension SwiftCore {
    public typealias HeapMetadata = TargetHeapMetadata<InProcess>

    public struct TargetHeapMetadata<Runtime> {
        public let `super`: TargetMetadata<Runtime>
    }
}

// MARK: - ValueMetadata
extension SwiftCore {
    public typealias ValueMetadata = TargetValueMetadata<InProcess>

    /// commom for struct or enum
    public struct TargetValueMetadata<Runtime> {
        public let `super`: TargetMetadata<Runtime>
        public var description: TargetValueTypeDescriptor<Runtime>?
    }
}

// MARK: - StructMetadata
extension SwiftCore {
    public typealias StructMetadata = TargetStructMetadata<InProcess>

    public struct TargetStructMetadata<Runtime> {
        let `super`: TargetValueMetadata<Runtime>
    }
}

// MARK: - Descriptor
extension SwiftCore {
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
*/
