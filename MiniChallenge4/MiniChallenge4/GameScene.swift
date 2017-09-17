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
import Foundation

class GameScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate {
    
    let hazardCategory: UInt32 = 0x1 << 0
    
    let neutrinoCategory: UInt32 = 0x1 << 1
    
    var functions = Array<Function>()
    
    var pinchGesture: UIPinchGestureRecognizer!
    
    var lastCenterPoint: CGPoint?
    
    var sceneSize: CGSize = CGSize(width: 0, height: 0)
    
    var functionLabel: SKLabelNode!
    
    var neutrino: SKSpriteNode!
    
    var firstDeltaY: CGFloat!
    
    var utilSpace: Double!
    
    var numberOfFunctionsAllowed: Double = 0
    
    var hazards: [SKSpriteNode] = []
    
    var winArea: SKShapeNode!
    
    var isPlaying = false
    
    var isDead = false
    
    var gameViewController: GameViewController!
    
    var blurEffectView: UIVisualEffectView!
    
    var levelIndex = 0
    
    var floatingSound: SKAudioNode!
    
    var deleteButton: SKButton!
    
    override func didMove(to view: SKView) {
        
        //CONFIGURATIONS
        
        self.physicsWorld.contactDelegate = self
        
        sceneSize = (self.view?.bounds.size)!
        
        utilSpace = Double(sceneSize.width) * 0.87
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.updatePinch))
        pinchGesture.delegate = self
        self.view?.addGestureRecognizer(pinchGesture)
        
        lastCenterPoint = pointProportionalTo(percentage: 0.08, and: 0.6)
        
        blurEffectView = UIVisualEffectView()
        
        blurEffectView.frame = (self.view?.frame)!
        
        self.view?.addSubview(blurEffectView)
        
        let floatingSoundd = SKAudioNode(fileNamed: Audio.FLOAT)
        floatingSound = floatingSoundd
        floatingSound.autoplayLooped = true
        floatingSound.isPositional = false
        
        //HUD ELEMENTS
        
        //UPPER MENU:
        
        let funcBox = SKSpriteNode(texture: SKTexture(imageNamed: "funcbox"),
                                   color: UIColor.white,
                                   size: sizeProportionalTo(percentage: 0.25, and: 0.1))
        funcBox.position = pointProportionalTo(percentage: 0.5, and: 0.94)
        funcBox.zPosition = 1.1
        self.addChild(funcBox)
        
        functionLabel = SKLabelNode(fontNamed: "Avenir")
        functionLabel.fontSize = funcBox.size.height * 0.5
        functionLabel.fontColor = SKColor.black
        functionLabel.position = pointProportionalTo(percentage: 0.5, and: 0.92)
        functionLabel.zPosition = 1.2
        self.addChild(functionLabel)
        
        let pauseButton = SKButton(pressed: "Pause Button_", neinPressed: "Pause Button", target: self, action: #selector(self.pauseGame))
        pauseButton.position = pointProportionalTo(percentage: 0.93, and: 0.9)
        pauseButton.scale(to: sizeProportionalTo(percentage: 0.09791666667, and: 0.1745589601))
        pauseButton.zPosition = 1.1
        self.addChild(pauseButton)
        
        
        //BOTTOM MENU:
        
        let bottomMenuBackground = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: sizeProportionalTo(percentage: 1, and: 0.2256267409)))
        bottomMenuBackground.fillColor = UIColor(red: 53 / 255, green: 79 / 255, blue: 149 / 255, alpha: 1)
        bottomMenuBackground.strokeColor = UIColor(red: 53 / 255, green: 79 / 255, blue: 149 / 255, alpha: 1)
        bottomMenuBackground.zPosition = 1.1
        self.addChild(bottomMenuBackground)
        
        deleteButton = SKButton(pressed: "ApagarButton_", neinPressed: "ApagarButton", target: self, action: #selector(removeActiveFunction))
        deleteButton.position = pointProportionalTo(percentage: 0.92, and: 0.11)
        deleteButton.scale(to: sizeProportionalTo(percentage: 0.09791666667, and: 0.1745589601))
        deleteButton.zPosition = 1.2
        self.addChild(deleteButton)
        
        let goButton = SKButton(pressed: "Go Button_", neinPressed: "Go Button", target: self, action: #selector(play))
        goButton.position = pointProportionalTo(percentage: 0.08, and: 0.11)
        goButton.scale(to: sizeProportionalTo(percentage: 0.09791666667, and: 0.1745589601))
        goButton.zPosition = 1.2
        self.addChild(goButton)
        
        let quadraticButton = SKButton(pressed: "2 Grau Button_", neinPressed: "2 Grau Button", target: self, action: #selector(addQuadraticFunction))
        quadraticButton.position = pointProportionalTo(percentage: 0.5, and: 0.12)
        quadraticButton.scale(to: sizeProportionalTo(percentage: 0.1286458333, and: 0.165273909))
        quadraticButton.zPosition = 1.2
        self.addChild(quadraticButton)
        
        let linearButton = SKButton(pressed: "Linear Button_", neinPressed: "Linear Button", target: self, action: #selector(addLinearFunction))
        linearButton.position = pointProportionalTo(percentage: 0.3, and: 0.12)
        linearButton.scale(to: sizeProportionalTo(percentage: 0.1286458333, and: 0.165273909))
        linearButton.zPosition = 1.2
        self.addChild(linearButton)
        
        let sinButton = SKButton(pressed: "Sin Button_", neinPressed: "Sin Button", target: self, action: #selector(addSinFunction))
        sinButton.position = pointProportionalTo(percentage: 0.7, and: 0.12)
        sinButton.scale(to: sizeProportionalTo(percentage: 0.1286458333, and: 0.165273909))
        sinButton.zPosition = 1.2
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
        if functions.last == nil {
            functionLabel.text = "Select a function"
        } else {
            functionLabel.text = functions.last?.toString()
        }
        
        if functions.count >= 2 {
            join(functions[functions.count - 2], functions[functions.count - 1])
        }
        
        if self.winArea.contains(neutrino.position) && isPlaying && !isDead {
            isPlaying = false
            var levels = UserDefaults.standard.array(forKey: "LevelProgression")
            levels?[levelIndex] = true
            UserDefaults.standard.set(levels, forKey: "LevelProgression")
            self.floatingSound.removeFromParent()
            let sound = SKAction.playSoundFileNamed(Audio.VICTORY, waitForCompletion: false)
            self.run(sound, completion: {
                self.gameViewController.winGame()
            })
            deleteButton.neinPressedImageName = "ApagarButton"
            deleteButton.pressedImageName = "ApagarButton_"
            deleteButton.texture = SKTexture(imageNamed: "ApagarButton")
        }
        
        if isDead && self.playerOutOfScreen() {
            isDead = false
            UIView.animate(withDuration: 1, animations: {
                self.blurEffectView.effect = UIBlurEffect(style: .dark)
            }, completion: {_ in
                UIView.animate(withDuration: 1, animations: {
                    self.blurEffectView.effect = nil
                    self.isPlaying = false
                    self.resetEverything()
                })
            })
        }
        
        if isPlaying && self.playerOutOfScreen() {
            neutrinoDiedTragically()
        }
    }
    
    func pauseGame() {
        let sound = SKAction.playSoundFileNamed(Audio.PAUSE, waitForCompletion: false)
        self.run(sound, completion: {
            self.view?.isPaused = true
            self.gameViewController.pauseGame()
        })
    }
    
    func playerOutOfScreen() -> Bool {
        let pos = neutrino.position
        return pos.y > sceneSize.height || pos.y < sceneSize.height * 0.2256267409
    }
    
    func neutrinoDiedTragically() {
        if !isDead {
            neutrino.removeAllActions()
            neutrino.texture = SKTexture(imageNamed: "Character Sad")
            neutrino.physicsBody?.affectedByGravity = true
            neutrino.physicsBody?.applyImpulse(CGVector(dx: 0, dy: neutrino.size.width / 7.5))
            isPlaying = false
            isDead = true
            self.floatingSound.removeFromParent()
            _ = Audio(named: Audio.DEATH, toPlayAt: self)
            deleteButton.neinPressedImageName = "ApagarButton"
            deleteButton.pressedImageName = "ApagarButton_"
            deleteButton.texture = SKTexture(imageNamed: "ApagarButton")
        }
    }
    
    func updatePinch() {
        if !isPlaying && functions.count > 0 {
            functions.last?.pinchUpdate(factor: pinchGesture.scale)
            updateAFunction()
            if functions.count == 1{
                join(neutrino, functions.first!)
            }
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
        if !isPlaying {
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
                _ = Audio(named: Audio.REMOVE_FUNCTION, toPlayAt: self)
            }
        } else {
            self.resetEverything()
        }
    }
    
    func resetEverything() {
        self.neutrino.removeAllActions()
        self.neutrino.removeFromParent()
        self.newNeutrino()
        self.floatingSound.removeFromParent()
        isPlaying = false
        deleteButton.neinPressedImageName = "ApagarButton"
        deleteButton.pressedImageName = "ApagarButton_"
        deleteButton.texture = SKTexture(imageNamed: "ApagarButton")
        
        //Colocando as funcoes de volta
        for f in functions{
            addChild(f.node!)
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
        if !isPlaying {
            if numberOfFunctionsAllowed == Double(functions.count) {
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
            functions.append(f)
            calculate(function: f)
            if functions.count == 1 {
                join(neutrino, functions.last!)
            }
            _ = Audio(named: Audio.FUNCTION_SELECTION, toPlayAt: self)
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
        if !functions.isEmpty && !isPlaying {
            
            //Rotina para tirar o caminho
            for f in functions {
                f.node?.removeFromParent()
            }
            
            neutrino.texture = SKTexture(imageNamed: "Character Wow")
            let action = SKAction.follow(createThePath(), speed: 60)
            self.addChild(floatingSound)
            neutrino.run(action) {
                if !self.winArea.contains(self.neutrino.position) {
                    self.neutrinoDiedTragically()
                }
                self.floatingSound.removeFromParent()
            }
            isPlaying = true
            deleteButton.neinPressedImageName = "Stop Button"
            deleteButton.pressedImageName = "Stop Button_"
            deleteButton.texture = SKTexture(imageNamed: "Stop Button")
        }
    }
    
    func addPlanets(planets: [String]) {
        var planet = SKSpriteNode(imageNamed: planets[0])
        planet.scale(to: sizeProportionalTo(percentage: 0.05729166667, and: 0.1021355617))
        planet.position = pointProportionalTo(percentage: 0.01, and: 0.6)
        planet.shadowedBitMask = 1
        planet.lightingBitMask = 1
        self.addChild(planet)
        
        planet = SKSpriteNode(imageNamed: planets[1])
        planet.scale(to: sizeProportionalTo(percentage: 0.05729166667, and: 0.1021355617))
        planet.position = pointProportionalTo(percentage: 0.99, and: 0.6)
        planet.shadowedBitMask = 1
        planet.lightingBitMask = 1
        
        winArea = SKShapeNode(circleOfRadius: planet.size.width * 0.9)
        winArea.position = planet.position
        winArea.strokeColor = UIColor.clear
        winArea.fillColor = UIColor.clear
        self.addChild(winArea)
        
        self.addChild(planet)
    }
    
    func createMeteor(_ point: CGPoint, _ scale: CGFloat){
        let newScale: CGFloat! = scale/246
        let textures = [SKTexture(imageNamed: "Asteroide Grande"), SKTexture(imageNamed: "Asteroide Pequeno")]
        let randomIndex = Int(arc4random_uniform(2))
        let meteor = SKSpriteNode(texture: textures[randomIndex])
        let newPoint: CGPoint!
        let scaleForTheHeight: CGFloat! = 85 / meteor.size.width
        if randomIndex == 0 {
            newPoint = CGPoint(x: point.x + #imageLiteral(resourceName: "Asteroide Grande").size.width/2, y: point.y + #imageLiteral(resourceName: "Asteroide Grande").size.height/2)
        } else {
            newPoint = CGPoint(x: point.x + #imageLiteral(resourceName: "Asteroide Pequeno").size.width/2, y: point.y + #imageLiteral(resourceName: "Asteroide Pequeno").size.height/2)
        }
        meteor.size.width = 85
        meteor.size.height *= scaleForTheHeight
        meteor.position = newPoint
        meteor.xScale = newScale
        meteor.yScale = newScale
        self.addChild(meteor)
        var random = Float(arc4random_uniform(390))
        random -= 190
        random /= 100
        if random == 0{
            random = Float(randomIndex)-0.1
        }
        let rotateAction = SKAction.rotate(byAngle: CGFloat(random), duration: 1)
        meteor.run(SKAction.repeatForever(rotateAction))
        meteor.shadowedBitMask = 1
        meteor.lightingBitMask = 1
        
        meteor.physicsBody = SKPhysicsBody(texture: meteor.texture!, size: meteor.size)
        meteor.physicsBody?.affectedByGravity = false
        meteor.physicsBody?.usesPreciseCollisionDetection = true
        meteor.physicsBody?.categoryBitMask = hazardCategory
        meteor.physicsBody?.contactTestBitMask = neutrinoCategory
        meteor.physicsBody?.collisionBitMask = 0x1 << 3
        
        hazards.append(meteor)
    }
    
    func newNeutrino(){
        neutrino = SKSpriteNode(imageNamed: "Character Idle")
        neutrino.scale(to: CGSize(width: Values.NEUTRINO_SIZE, height: Values.NEUTRINO_SIZE))
        neutrino.position = pointProportionalTo(percentage: 0.08, and: 0.6)
        
        neutrino.physicsBody = SKPhysicsBody(texture: neutrino.texture!,
                                             size: CGSize(width: neutrino.size.width * 0.5,
                                                          height: neutrino.size.height * 0.5))
        neutrino.physicsBody?.affectedByGravity = false
        neutrino.physicsBody?.usesPreciseCollisionDetection = true
        neutrino.physicsBody?.categoryBitMask = neutrinoCategory
        neutrino.physicsBody?.contactTestBitMask =  hazardCategory
        neutrino.physicsBody?.collisionBitMask = 0x1 << 2
        
        
        let neutrinoLight = SKLightNode()
        neutrinoLight.falloff = 1
        neutrinoLight.ambientColor = UIColor.lightGray
        neutrino.addChild(neutrinoLight)
        
        self.addChild(neutrino)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == neutrinoCategory &&
            contact.bodyB.categoryBitMask == hazardCategory {
            neutrinoDiedTragically()
        }
    }
    
    func convert(sketchX: Int, sketchY: Int) -> CGPoint{
        //TODO: adicionar metade do tamanho do node
        let newX = (sceneSize.width/1920)*CGFloat(sketchX)
        let newY = (sceneSize.height/1080)*CGFloat(sketchY)
        return CGPoint(x: newX, y: newY)
    }
    
    
    
}
