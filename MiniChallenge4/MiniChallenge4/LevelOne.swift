//
//  LevelOne.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 11/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class LevelOne: GameScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.addPlanets(planets: ["Plutao 2", "Netuno 2"])
    }
    
}
