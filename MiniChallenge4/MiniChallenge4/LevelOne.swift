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
    
    var meteors: [SKSpriteNode]!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.addPlanets(planets: ["Plutao 2", "Netuno 2"])
    }
    
    func createMeteor(_ point: CGPoint, _ scale: CGFloat){
        let textures = [SKTexture(imageNamed: "Asteroide Grande"), SKTexture(imageNamed: "Asteroide Pequeno")]
        var meteor: SKSpriteNode = SKSpriteNode(texture: textures[arc4random_uniform(2)])
        meteor.position = point
        meteor.scale = scale
        self.addChild(meteor)
        let rotateAction = SKAction.rotate(byAngle: arc4random_uniform(90), duration: 1)
        meteor.run(SKAction.repeatForever(rotateAction))
    }
    
}

extension CGFloat {
    func degreesToRadians() -> CGFloat {
        return self * CGFloat.pi / 180
    }
}
