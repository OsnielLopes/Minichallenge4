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
    
    var a: Double = 1
    
    var b: Double = 0
    
    override init() {
        super.init()
        self.setRange(step: 0.1, min: -2 * Double.pi, max: 2 * Double.pi)
    }
    
    override func f(x: Double) -> Double {
        return sin(a * x) + b
    }
    
    override func getScale() -> Double {
        return 15
    }
    
    override func pinchUpdate(factor: CGFloat) {
        a -= Double(factor) / 25
    }
    
    override func swipeUpdate(factor: CGPoint) {
        b += Double(factor.y) / 1000 * -1
    }
}
