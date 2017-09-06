//
//  SKFunctionNode.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 04/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import SpriteKit

class Function {
    
    var node: SKShapeNode?
    
    var functionPath: CGMutablePath?
    
    var range: [Double] = []
    
    var scale: Double = 0
    
    init(scale: Double) {
        self.scale = scale
    }
    
    func drawFunction(width: Double, height: Double) {
        let functionPoints: [CGPoint] = range.map({ scale(x: Double($0), y: f(x: Double($0)), widht: width, height: height) })
        functionPath = CGMutablePath()
        functionPath?.addLines(between: functionPoints)
        node = SKShapeNode(path: functionPath!)
        node?.lineWidth = 1
        node?.strokeColor = .white
    }
    
    func scale(x: Double, y: Double, widht: Double, height: Double) -> CGPoint {
        return CGPoint(x: (widht *  x) / scale,
                       y: (height * y) / scale)
    }
    
    func f(x: Double) -> Double {
        return 0
    }
        
    func setRange(step: Double, min: Double, max: Double) {
        range = stride(from: min, to: max, by: step).map({ n in n })
    }
    
    func pinchUpdate(factor: CGFloat) { }
}
