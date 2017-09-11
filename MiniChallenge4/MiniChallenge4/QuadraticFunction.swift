//
//  QuadraticFunction.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 05/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import SpriteKit

class QuadraticFunction: Function {
        
    override init(scale: Double) {
        super.init(scale: scale)
        self.setRange(step: 1, min: Values.START, max: Values.END)
    }
    
    override func drawFunction(width: Double, height: Double) {
        super.drawFunction(width: width, height: height)
        self.node?.name = "QuadraticFunction"
    }
    
    override func f(x: Double) -> Double {
        return a * pow(x, 2)
    }
    
    override func pinchUpdate(factor: CGFloat) {
        var newFactor = factor
        var amount: CGFloat!
        if factor > 1{
            newFactor = newFactor - newFactor.rounded(FloatingPointRoundingRule.down)
            amount = newFactor * 0.05
        } else{
            newFactor = 1 - newFactor
            amount = newFactor * -0.05
        }
        a += Double(amount)
    }
    
    override func toString() -> String {
        if a != 1{
            return "f(x) ="+String(a)+"x²"
        }else{
            return "f(x) = x²"
        }
    }

    
}
