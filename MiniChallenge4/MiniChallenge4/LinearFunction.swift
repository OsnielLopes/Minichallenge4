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
    
    override init() {
        super.init()
        self.setRange(step: 1, min: -10, max: 10)
    }
    
    override func f(x: Double) -> Double {
        return x
    }
    
}
