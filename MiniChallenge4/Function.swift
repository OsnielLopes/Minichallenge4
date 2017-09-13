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
    
    var domain: [Double] = []
    
    var scale: Double = 0
    
    var functionPoints: [CGPoint] = []
    
    var a: Double = 1
        
    init(scale: Double) {
        self.scale = scale
    }
    
    func drawFunction(width: Double, height: Double) {
        functionPoints = domain.map({ scale(x: Double($0), y: f(x: Double($0)), widht: width, height: height) })
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
        domain = stride(from: min, to: max, by: step).map({ n in n })
    }
    
    func pinchUpdate(factor: CGFloat) { }
    
    func deltaY() -> CGFloat{
        var lower = functionPoints.first?.y
        var higher = functionPoints.first?.y
        for p in 1..<functionPoints.count{
            if functionPoints[p].y < lower!{
                lower = functionPoints[p].y
            } else if functionPoints[p].y > higher!{
                higher = functionPoints[p].y
            }
            
        }
        return higher! - lower!
    }
    
    func deltaX() -> CGFloat{
        return functionPoints.last!.x - functionPoints.first!.x
    }
    
    func toString() -> String{
        preconditionFailure("This method must be overridden")
    }
}
