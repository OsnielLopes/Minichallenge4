//
//  GameScene.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 04/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var activeFunction: Function?
    
    override func didMove(to view: SKView) {
        activeFunction = LinearFunction()
        calculateFunction()
    }
    
    func calculateFunction() {
        if activeFunction?.node != nil {
            activeFunction?.node?.removeFromParent()
        }
        activeFunction?.drawFunction(width:  Double((self.view?.frame.width)!),
                                     height: Double((self.view?.frame.height)!))
        activeFunction?.node?.position = (self.view?.center)!
        self.addChild((activeFunction?.node!)!)
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        calculateFunction()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
}
