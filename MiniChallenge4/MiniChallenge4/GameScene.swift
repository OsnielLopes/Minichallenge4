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
    
    var swipeGesture: UIPanGestureRecognizer!
    
    var beginningTouch: CGPoint?
    
    var movingTouch: CGPoint?
    
    override func didMove(to view: SKView) {
        activeFunction = LinearFunction()
        calculateFunction()
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.updatePinch))
        pinchGesture.delegate = self
        self.view?.addGestureRecognizer(pinchGesture)
        
        swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(self.updateSwipe))
        swipeGesture.delegate = self
        self.view?.addGestureRecognizer(swipeGesture)
    }
    
    func updatePinch() {
        activeFunction?.pinchUpdate(factor: pinchGesture.velocity * pinchGesture.scale)
        calculateFunction()
    }
    
    func updateSwipe() {
        activeFunction?.swipeUpdate(factor: swipeGesture.velocity(in: self.view))
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
    
    override func update(_ currentTime: TimeInterval) {
    }
}
