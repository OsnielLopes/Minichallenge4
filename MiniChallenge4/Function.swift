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
    
    var functionPoints: [CGPoint] = []
        
    func drawFunction(width: Double, height: Double) {
        generatePoints(width: width, height: height)
        functionPath = CGMutablePath()
        functionPath?.addLines(between: functionPoints)
        node = SKShapeNode(path: functionPath!)
        node?.lineWidth = 1
        node?.strokeColor = .white
    }
    
    func scale(x: Double, y: Double, widht: Double, height: Double) -> CGPoint {
        return CGPoint(x: widht *  x / 100,
                       y: height * y / 100)
    }
    
    func generatePoints(width: Double, height: Double) {
        functionPoints = (-100...100).map({
            scale(x: Double($0), y: f(x: Double($0)), widht: width, height: height)
        })
    }
    
    func f(x: Double) -> Double {
        return sin(x)
    }
    
}
