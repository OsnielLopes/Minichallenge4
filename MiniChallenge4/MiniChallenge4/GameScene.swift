//
//  GameScene.swift
//  MiniChallenge4
//
//  Created by Guilherme Paciulli & Osniel Teixeira on 04/09/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene, UIGestureRecognizerDelegate {
    
    var functions = Array<Function>()
    
    var pinchGesture: UIPinchGestureRecognizer!
    
    var lastCenterPoint: CGPoint?
    
    var sceneSize: CGSize = CGSize(width: 0, height: 0)
    
    var functionLabel: SKLabelNode!
    
    var neutrino: SKSpriteNode!
    
    var firstDeltaY: CGFloat!
    
    var utilSpace: Double!
    
    var numberOfFunctionsAllowed: Double = 0
    
    override func didMove(to view: SKView) {
        
        //CONFIGURATIONS
        
        sceneSize = (self.view?.bounds.size)!
        
        utilSpace = Double(sceneSize.width) * 0.87
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.updatePinch))
        pinchGesture.delegate = self
        self.view?.addGestureRecognizer(pinchGesture)
        
        lastCenterPoint = pointProportionalTo(percentage: 0.08, and: 0.6)
        
        numberOfFunctionsAllowed = 1
        
        
        //HUD ELEMENTS
        
        functionLabel = SKLabelNode(fontNamed: "Cochin")
        functionLabel.fontSize = 20
        functionLabel.fontColor = SKColor.white
        functionLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(functionLabel)
        
        //Bottom menu:
        
        let bottomMenuBackground = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: sizeProportionalTo(percentage: 1, and: 0.2256267409)))
        bottomMenuBackground.fillColor = UIColor(red: 53 / 255, green: 79 / 255, blue: 149 / 255, alpha: 1)
        bottomMenuBackground.strokeColor = UIColor(red: 53 / 255, green: 79 / 255, blue: 149 / 255, alpha: 1)
        self.addChild(bottomMenuBackground)
        
        let deleteButton = SKButton(pressed: "ApagarButton_", neinPressed: "ApagarButton", target: self, action: #selector(removeActiveFunction))
        deleteButton.position = pointProportionalTo(percentage: 0.92, and: 0.11)
        deleteButton.scale(to: sizeProportionalTo(percentage: 0.09791666667, and: 0.1745589601))
        self.addChild(deleteButton)
        
        let goButton = SKButton(pressed: "Go Button", neinPressed: "Go Button_", target: self, action: #selector(play))
        goButton.position = pointProportionalTo(percentage: 0.08, and: 0.11)
        goButton.scale(to: sizeProportionalTo(percentage: 0.09791666667, and: 0.1745589601))
        self.addChild(goButton)
        
        let quadraticButton = SKButton(pressed: "2 Grau Button", neinPressed: "2 Grau Button_", target: self, action: #selector(addQuadraticFunction))
        quadraticButton.position = pointProportionalTo(percentage: 0.5, and: 0.12)
        quadraticButton.scale(to: sizeProportionalTo(percentage: 0.1286458333, and: 0.165273909))
        self.addChild(quadraticButton)
        
        let linearButton = SKButton(pressed: "Linear Button", neinPressed: "Linear Button_", target: self, action: #selector(addLinearFunction))
        linearButton.position = pointProportionalTo(percentage: 0.3, and: 0.12)
        linearButton.scale(to: sizeProportionalTo(percentage: 0.1286458333, and: 0.165273909))
        self.addChild(linearButton)
        
        let sinButton = SKButton(pressed: "Sin Button", neinPressed: "Sin Button_", target: self, action: #selector(addSinFunction))
        sinButton.position = pointProportionalTo(percentage: 0.7, and: 0.12)
        sinButton.scale(to: sizeProportionalTo(percentage: 0.1286458333, and: 0.165273909))
        self.addChild(sinButton)
        
        
        //STANDART GAME ELEMENTS
        
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "Ceu"), color: UIColor.white, size: sceneSize)
        bg.position = (self.view?.center)!
        bg.zPosition = -1
        self.addChild(bg)
        
        newNeutrino()
    }
    
    func pointProportionalTo(percentage widht: CGFloat, and height: CGFloat) -> CGPoint {
        return CGPoint(x: widht * sceneSize.width, y: height * sceneSize.height)
    }
    
    func sizeProportionalTo(percentage widht: CGFloat, and height: CGFloat) -> CGSize {
        return CGSize(width: widht * sceneSize.width, height: height * sceneSize.height)
    }
    
    override func update(_ currentTime: TimeInterval) {
        functionLabel.text = functions.last?.toString()
        if functions.count >= 2 {
            join(functions[functions.count - 2], functions[functions.count - 1])
        }
    }
    
    func updatePinch() {
        functions.last?.pinchUpdate(factor: pinchGesture.scale)
        updateAFunction()
        if functions.count == 1{
            join(neutrino, functions.first!)
        }
    }
    
    func calculate(function: Function) {
        functions.last?.node?.removeFromParent()
        functions.last?.drawFunction(width:  Double((self.view?.frame.width)!),
                                    height: Double((self.view?.frame.height)!))
        functions.last?.node?.position = lastCenterPoint!
        self.addChild((functions.last?.node!)!)
        
        lastCenterPoint = CGPoint(x: (functions.last?.functionPoints.last!.x)! + lastCenterPoint!.x + ((functions.last?.deltaX())! / 2),
                                  y: (functions.last?.functionPoints.last!.y)! + lastCenterPoint!.y)
    }
    
    func updateAFunction(){
        let point = functions.last?.node?.position
        functions.last?.node?.removeFromParent()
        functions.last?.drawFunction(width:  Double((self.view?.frame.width)!),
                                     height: Double((self.view?.frame.height)!))
        functions.last?.node?.position = point!
        self.addChild((functions.last?.node!)!)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        for n in self.children{
            if n.contains(pos), let button = n as? SKButton {
                button.press()
                break
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func removeActiveFunction(){
        if functions.count > 0 {
            functions.last?.node?.removeFromParent()
            functions.remove(at: functions.count-1)
            if functions.count >= 1{
                let point = CGPoint(x: (functions.last?.functionPoints.last!.x)! + (functions.last?.node?.position.x)! + CGFloat(utilSpace / (2 * numberOfFunctionsAllowed)),
                                    y: (functions.last?.functionPoints.last!.y)! + (functions.last?.node?.position.y)!)
                lastCenterPoint = point
            }else{
                lastCenterPoint = neutrino.position
            }
        }
    }
    
    func addLinearFunction() {
        addFunction(f: LinearFunction(scale: Double((self.view?.frame.width)!),
                                      -utilSpace / (2 * numberOfFunctionsAllowed),
                                      utilSpace / (2 * numberOfFunctionsAllowed)))
    }
    
    func addQuadraticFunction() {
        addFunction(f: QuadraticFunction(scale: Double((self.view?.frame.width)!),
                                         -utilSpace / (2 * numberOfFunctionsAllowed),
                                         utilSpace / (2 * numberOfFunctionsAllowed)))
    }
    
    func addSinFunction() {
        addFunction(f: SinFunction(scale: Double((self.view?.frame.width)!),
                                   -utilSpace / (2 * numberOfFunctionsAllowed),
                                   utilSpace / (2 * numberOfFunctionsAllowed)))
    }
    
    func addFunction(f: Function) {
        if numberOfFunctionsAllowed > Double(functions.count) {
            functions.append(f)
            calculate(function: f)
            if functions.count == 1 {
                join(neutrino, functions.last!)
            }
        }
    }
    
    /// Joins the last two functions
    func join(_ aObject: Any, _ funcB: Function){
        
        var deltaY: CGFloat!
        var deltaX: CGFloat = 0
        
        if let funcA = aObject as? Function, !(funcA.node?.hasActions())! && !(funcB.node?.hasActions())! {
            //Find the variation between the value of y of the last point of a function and the first of the next one
            deltaY = (funcA.node?.convert((funcA.functionPoints.last)!, to: self).y)! - (funcB.node?.convert((funcB.functionPoints.first)!, to: self).y)!
        } else if aObject is SKSpriteNode{
            deltaY = neutrino.position.y - (funcB.node?.convert((funcB.functionPoints.first)!, to: self).y)!
            deltaX = neutrino.position.x - (funcB.node?.convert((funcB.functionPoints.first)!, to: self).x)!
            lastCenterPoint = CGPoint(x: (functions.last?.node?.position.x)! + deltaX + (functions.last?.deltaX())!,
                                      y: (functions.last?.node?.position.y)! + deltaY)
            firstDeltaY = deltaY
        }
        
        //Repositions a node
        functions.last?.node?.position = CGPoint(x: (functions.last?.node?.position.x)! + deltaX,
                                                 y: (functions.last?.node?.position.y)! + deltaY)
    }
    
    func deltaY(_ funcA: Function, _ funcB: Function) -> CGFloat{
        return (funcA.functionPoints.last?.y)! - (funcB.functionPoints.first?.y)!
    }
    
    /// Creates the path formed by the union of all functions.
    func createThePath() -> CGMutablePath{
        let path = CGMutablePath()
        var deltaYBefore:CGFloat = -(functions.first?.functionPoints.first!.y)!
        for i in 0..<functions.count {
            if i>0{
                deltaYBefore = deltaYBefore + deltaY(functions[i-1], functions[i])
            }
            var newPoints = functions[i].functionPoints
            for j in 0..<newPoints.count {
                let subtraction = ((functions[i].functionPoints.last?.x)! - (functions[i].functionPoints.first?.x)!)
                let utilSpaceSlash4 = CGFloat(utilSpace / (2 * numberOfFunctionsAllowed))
                newPoints[j].x = newPoints[j].x + (CGFloat(i) * subtraction) + utilSpaceSlash4
                newPoints[j].y = newPoints[j].y + deltaYBefore
                if i == 0 && j == 0{
                    path.move(to: CGPoint(x:0,y:0))
                }else{
                    path.addLine(to: newPoints[j])
                }
            }
        }
        return path
    }
    
    /// Makes the neutrino run
    func play(){
        if !functions.isEmpty{
            let action = SKAction.follow(createThePath(), speed: 60)
            neutrino.run(action) {
                self.neutrino.removeFromParent()
                self.newNeutrino()
            }
        }
    }
    
    func addPlanets(planets: [String]) {
        var planet = SKSpriteNode(imageNamed: planets[0])
        planet.scale(to: sizeProportionalTo(percentage: 0.05729166667, and: 0.1021355617))
        planet.position = pointProportionalTo(percentage: 0.01, and: 0.6)
        self.addChild(planet)
        planet = SKSpriteNode(imageNamed: planets[1])
        planet.scale(to: sizeProportionalTo(percentage: 0.05729166667, and: 0.1021355617))
        planet.position = pointProportionalTo(percentage: 0.99, and: 0.6)
        self.addChild(planet)
    }
    
    func newNeutrino(){
        neutrino = SKSpriteNode(imageNamed: "neutrino")
        neutrino.scale(to: CGSize(width: Values.NEUTRINO_SIZE, height: Values.NEUTRINO_SIZE))
        neutrino.position = pointProportionalTo(percentage: 0.08, and: 0.6)
        self.addChild(neutrino)
    }
    
}
