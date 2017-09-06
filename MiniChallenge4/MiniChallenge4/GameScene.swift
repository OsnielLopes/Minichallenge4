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
    
    var functions: [Function] = []
    
    var pinchGesture: UIPinchGestureRecognizer!
    
    var lastCenterPoint: CGPoint?
    
    override func didMove(to view: SKView) {
        lastCenterPoint = CGPoint(x: (self.view?.frame.width)! * 0.15, y: (self.view?.frame.height)! * 0.5)
        
        activeFunction = SinFunction(scale: Double((self.view?.frame.width)!) / 2)
        initializeFuntion(function: activeFunction!)
        var lastPoint = activeFunction?.functionPoints.last
        
        activeFunction = LinearFunction(scale: Double((self.view?.frame.width)!) / 2)
        initializeFuntion(function: activeFunction!)
        var newPoint = activeFunction?.functionPoints.first
        
        var deltaY = lastPoint.y - newPoint?.y
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.updatePinch))
        pinchGesture.delegate = self
        self.view?.addGestureRecognizer(pinchGesture)
    }
    
    func updatePinch() {
        activeFunction?.pinchUpdate(factor: pinchGesture.velocity * pinchGesture.scale)
        calculate(function: activeFunction!)
    }
    
    func initializeFuntion(function: Function) {
        activeFunction = function
        functions.append(function)
        calculate(function: function)
    }
    
    func calculate(function: Function) {
        
        let point = CGPoint(x: (activeFunction?.functionPoints.last!.x)! + lastCenterPoint!.x + 20,
                            y: (activeFunction?.functionPoints.last!.y)! + lastCenterPoint!.y)
        
        activeFunction?.drawFunction(width:  Double((self.view?.frame.width)!),
                                     height: Double((self.view?.frame.height)!))
        activeFunction?.node?.position = lastCenterPoint!
        
        self.addChild((activeFunction?.node!)!)
        lastCenterPoint = point
    }
}
