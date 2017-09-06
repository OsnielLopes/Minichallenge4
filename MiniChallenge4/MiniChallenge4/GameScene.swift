//
//  GameScene.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli on 04/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene, UIGestureRecognizerDelegate {
    
    var activeFunction: Function?
    
    var pinchGesture: UIPinchGestureRecognizer!
    
    var lastCenterPoint: CGPoint?
    
    override func didMove(to view: SKView) {
        lastCenterPoint = CGPoint(x: (self.view?.frame.width)! * 0.2, y: (self.view?.frame.height)! * 0.5)
        
        activeFunction = SinFunction(scale: Double((self.view?.frame.width)! * 0.6 / 10))
        calculateFunction()
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.updatePinch))
        pinchGesture.delegate = self
        self.view?.addGestureRecognizer(pinchGesture)
    }
    
    func updatePinch() {
        activeFunction?.pinchUpdate(factor: pinchGesture.velocity * pinchGesture.scale)
        calculateFunction()
    }
    
    func calculateFunction() {
        if activeFunction?.node != nil {
            activeFunction?.node?.removeFromParent()
        }
        activeFunction?.drawFunction(width:  Double((self.view?.frame.width)!),
                                     height: Double((self.view?.frame.height)!))
        activeFunction?.node?.position = lastCenterPoint!
        self.addChild((activeFunction?.node!)!)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
