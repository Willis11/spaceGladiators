//
//  GameScene.swift
//  ps4ControllerGame
//
//  Created by Jude Willis on 31/07/2020.
//  Copyright © 2020 Jude Willis. All rights reserved.
//

import SpriteKit
import GameplayKit
import GameController

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var box = SKSpriteNode(color: SKColor.red, size: CGSize(width: 40, height: 40))
    var box2 = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 40, height: 40))
    var xVal : Float! = 0
    var yVal : Float! = 0
    var RxVal : Float! = 0
    
    var xVal2 : Float! = 0
    var yVal2 : Float! = 0
    var RxVal2 : Float! = 0
    
    var bulletAllowedTime : Int = 0
    let rotationOffSet = CGFloat.pi/2
    
    var counterTime : Int = 0
    var runningTime : Int = 0
    var gameFinished = false
    
    override func didMove(to view: SKView) {
        print("Called")
        
        view.showsPhysics = true
        self.physicsWorld.contactDelegate = self
        
        observeForGameControllers()
        box.position = CGPoint(x: 0, y: -200)
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 40))
        box.physicsBody?.isDynamic = true
        box.physicsBody?.affectedByGravity = false
        box.physicsBody?.friction = 0
        box.physicsBody?.categoryBitMask = 000001
        
        
        box2.position = CGPoint(x: 0, y: 200)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 40))
        box2.physicsBody?.affectedByGravity = false
        box2.physicsBody?.restitution = 1
        box2.physicsBody?.friction = 0
        box2.physicsBody?.categoryBitMask = 000010
           
        box2.zRotation = 3.15
        addChild(box)
        addChild(box2)
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.restitution = 1
        border.isDynamic = true
        border.categoryBitMask = 0b0001
        self.physicsBody = border
    }
    
    
    func collisionBetween(bullet: SKNode, object: SKNode) {
            object.removeFromParent()
            runningTime = 0
            gameFinished = true
            let winLabel = SKLabelNode(fontNamed: "Futura Bold")
            winLabel.text = "Player 1 Wins!"
            winLabel.fontSize = 40
            winLabel.position = CGPoint(x: 0, y: 0)
            addChild(winLabel)
            
       }
       
       func collisionBetween2(bullet2: SKNode, object: SKNode) {
            object.removeFromParent()
            runningTime = 0
            gameFinished = true
            let winLabel = SKLabelNode(fontNamed: "Futura Bold")
            winLabel.text = "Player 2 Wins!"
            winLabel.fontSize = 40
            winLabel.position = CGPoint(x: 0, y: 0)
            addChild(winLabel)
                
        }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "bullet" {
               collisionBetween(bullet: contact.bodyA.node!, object: contact.bodyB.node!)
           } else if contact.bodyB.node?.name == "bullet" {
               collisionBetween(bullet: contact.bodyB.node!, object: contact.bodyA.node!)
        }
        
        if contact.bodyA.node?.name == "bullet2" {
            collisionBetween2(bullet2: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "bullet2" {
            collisionBetween2(bullet2: contact.bodyB.node!, object: contact.bodyA.node!)
        
        }
    }
    
   
    
    override func update(_ currentTime: TimeInterval) {
        
        print("IsCalled")
        if(self.isPaused == true){
            print("Game Paused")
        }
        
        box.physicsBody?.velocity = CGVector(dx: Double(xVal * 300.0), dy: Double(yVal * 500.0))
        box.physicsBody?.angularVelocity = CGFloat(-RxVal * 8)
      
        box2.physicsBody?.velocity = CGVector(dx: Double(xVal2 * 300.0), dy: Double(yVal2 * 500.0))
        box2.physicsBody?.angularVelocity = CGFloat(-RxVal2 * 8)
        
        
        //print("Game On")
        bulletAllowedTime += 1
        
        counterTime += 1
        if(counterTime == 75){
            runningTime += 1
            counterTime = 0
        }
        
      //  print(runningTime)
        
        if(runningTime == 5 && gameFinished == true){
            let newScene = startScene(size: CGSize(width: 400, height: 600))
            newScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            newScene.scaleMode = .resizeFill
          let animation = SKTransition.fade(withDuration: 1)
            view?.presentScene(newScene, transition: animation)
        }
        
    }
    
    func observeForGameControllers(){
        print("Called 2")
        NotificationCenter.default.addObserver(self, selector: #selector(connectControllers), name: NSNotification.Name.GCControllerDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disconnectControllers), name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
    }
    
    @objc func connectControllers() {
    print("Connected")
    //Unpause the Game if it is currently paused
    self.isPaused = false
    //Used to register the Nimbus Controllers to a specific Player Number
    var indexNumber = 0
    // Run through each controller currently connected to the system
    for controller in GCController.controllers() {
    //Check to see whether it is an extended Game Controller (Such as a Nimbus)
    if controller.extendedGamepad != nil {
    controller.playerIndex = GCControllerPlayerIndex.init(rawValue: indexNumber)!
    indexNumber += 1
    setupControllerControls(controller: controller)
            }
        }
    }
    @objc func disconnectControllers() {
    // Pause the Game if a controller is disconnected ~ This is mandated by Apple
    self.isPaused = true
    print("Controller Disconnected")
    }
    
    func setupControllerControls(controller: GCController) {
    //Function that check the controller when anything is moved or pressed on it
    controller.extendedGamepad?.valueChangedHandler = {
    (gamepad: GCExtendedGamepad, element: GCControllerElement) in
    // Add movement in here for sprites of the controllers
    self.controllerInputDetected(gamepad: gamepad, element: element, index: controller.playerIndex.rawValue)
        }
    }
}
