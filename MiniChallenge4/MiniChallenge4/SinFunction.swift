//
//  SinFunction.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 05/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import SpriteKit

class SinFunction: Function {
        
    init(scale: Double, _ start: Double, _ end: Double) {
        super.init(scale: scale)
        self.setRange(step: 0.1, min: start, max: end)
    }
    
    override func drawFunction(width: Double, height: Double) {
        super.drawFunction(width: width, height: height)
        self.node?.name = "SinFunction"
    }
    
    override func f(x: Double) -> Double {
        return a * sin(0.25 * x)
    }
    
    override func pinchUpdate(factor: CGFloat) {
        var newFactor = factor
        var amount: CGFloat!
        if factor > 1{
            newFactor = newFactor - newFactor.rounded(FloatingPointRoundingRule.down)
            amount = newFactor * 3
        } else{
            newFactor = 1 - newFactor
            amount = newFactor * -3
        }
        a += Double(amount)
    }
    
    override func toString() -> String {
        if a != 1{
            return "f(x) = \(Double(round(100 * a) / 100))sen(x)"
        }else{
            return "f(x) = sen(x)"
        }
    }
}
