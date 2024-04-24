//
//  TaskHook.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/4/19.
//

import Foundation

/// https://forums.swift.org/t/concurrency-runtime-main-executor-hook-behaviour/62551

/// From file: MainActor.swift
/// UnownedSerialExecutor(Builtin.buildMainActorExecutorRef())
///
/// From file: Builins.def
/// 名词解析：builtin function （内置函数）
/// buildMainActorExecutorRef
///
/// From file: GenConcurrency.h
/// void emitBuildMainActorExecutorRef(IRGenFunction &IGF, Explosion &out);
///
/// getTaskGetMainExecutorFunctionPointer
///
/// From file: RuntimeFunctions.def
/// swift_task_getMainExecutor
///
/// GlobalExecutor.cpp
///
/// 返回 ExecutorRef，为协议 SerialExecutor 的实现
///
/// 结论：只直接分配到 queue 中，而不经过 swift_task_enqueueMainExecutor
///
///
/// http://www.cydiasubstrate.com/api/c/MSFindSymbol/
/// https://cloud.tencent.com/developer/article/1339855
/// https://github.com/facebook/fishhook

@_silgen_name("swift_task_enqueueMainExecutor")
func _enqueueMain(_ job: UnownedJob)

@globalActor
public final actor MyMainActor: GlobalActor, SerialExecutor {

    public static let shared = MyMainActor()

    nonisolated public var unownedExecutor: UnownedSerialExecutor {
        asUnownedSerialExecutor()
    }

    nonisolated public func enqueue(_ job: UnownedJob) {
        _enqueueMain(job)
    }

    nonisolated public func asUnownedSerialExecutor() -> UnownedSerialExecutor {
        UnownedSerialExecutor(ordinary: self)
    }
}
