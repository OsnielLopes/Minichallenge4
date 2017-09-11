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
        
    override init(scale: Double) {
        super.init(scale: scale)
        self.setRange(step: 1, min: Values.START, max: Values.END)
    }
    
    override func drawFunction(width: Double, height: Double) {
        super.drawFunction(width: width, height: height)
        self.node?.name = "SinFunction"
    }
    
    override func f(x: Double) -> Double {
        return sin(a * x)
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
        if a < -15.5 {
            a = -15.5
        } else if a > 9 {
            a = 9
        }
    }
    
    override func toString() -> String {
        if a != 1{
            return "f(x) = sen("+String(a)+"x)"
        }else{
            return "f(x) = sen(x)"
        }
    }
}
