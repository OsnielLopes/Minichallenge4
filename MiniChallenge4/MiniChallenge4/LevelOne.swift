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
        
        let meteorsDescription = [
            [self.convert(sketchX: 308, sketchY: 682), 149],
            [self.convert(sketchX: 494, sketchY: 437), 99],
            [self.convert(sketchX: 564, sketchY: 758), 149],
            [self.convert(sketchX: 657, sketchY: 455), 121],
            [self.convert(sketchX: 743, sketchY: 734), 99],
            [self.convert(sketchX: 776, sketchY: 394), 63],
            [self.convert(sketchX: 829, sketchY: 840), 149],
            [self.convert(sketchX: 855, sketchY: 394), 149],
            [self.convert(sketchX: 891, sketchY: 732), 99],
            [self.convert(sketchX: 992, sketchY: 337), 63],
            [self.convert(sketchX: 1032, sketchY: 758), 215],
            [self.convert(sketchX: 1035, sketchY: 337), 246],
            [self.convert(sketchX: 1309, sketchY: 682), 103],
            [self.convert(sketchX: 1559, sketchY: 774), 77]
        ]
        
        for meteor in meteorsDescription{
            self.createMeteor(meteor[0] as! CGPoint, CGFloat(meteor[1] as! Int))
        }
    }
    
    func didWon(){
        ///TODO: mudar o vetor de levels
    }
}
