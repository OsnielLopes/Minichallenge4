//
//  LinearFunction.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 05/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import SpriteKit

class LinearFunction: Function {
    
    init(scale: Double, _ start: Double, _ end: Double) {
        super.init(scale: scale)
        self.setRange(step: 1, min: start, max: end)
    }
    
    override func drawFunction(width: Double, height: Double) {
        super.drawFunction(width: width, height: height)
        self.node?.name = "LinearFunction"
    }
    
    override func f(x: Double) -> Double {
        return a * x
    }
    
    override func pinchUpdate(factor: CGFloat) {
        var newFactor = factor
        var amount: CGFloat!
        if factor > 1{
            newFactor = newFactor - newFactor.rounded(FloatingPointRoundingRule.down)
            amount = newFactor
        } else{
            newFactor = 1 - newFactor
            amount = newFactor * -1
        }
        if a > 10 {
            a = 10
        } else if a < -10 {
            a = -10
        }
        a += Double(amount)
    }
    
    override func toString() -> String {
        if a != 1{
            return "f(x) = "+String(Double(round(1000 * a) / 100))+"x"
        } else{
            return "f(x) = x"
        }
    }
    
}
