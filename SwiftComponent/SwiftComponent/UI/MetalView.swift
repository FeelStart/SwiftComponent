//
//  MetalView.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/3/6.
//

import UIKit
import Metal

open class MetalView: UIView {

    private var device: MTLDevice!
    private var commandQueue: MTLCommandQueue?
    private var commadBuffer: MTLCommandBuffer?
    private var commandEncoder: MTLCommandEncoder?

    public override init(frame: CGRect) {
        super.init(frame: frame)

        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Don't support MetalView.")
        }
        self.device = device
        commandQueue = self.device.makeCommandQueue()
        commadBuffer = commandQueue?.makeCommandBuffer()
        commandEncoder = commadBuffer?.makeComputeCommandEncoder()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
