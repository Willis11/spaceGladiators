//
//  controls.swift
//  ps4ControllerGame
//
//  Created by Jude Willis on 31/07/2020.
//  Copyright © 2020 Jude Willis. All rights reserved.
//

import Foundation
import GameController
import SpriteKit

extension GameScene{
    
    
    func controllerInputDetected(gamepad: GCExtendedGamepad, element: GCControllerElement, index: Int){
        if (gamepad.leftThumbstick == element && index == 0)
        {
        
            xVal = gamepad.leftThumbstick.xAxis.value
            yVal = gamepad.leftThumbstick.yAxis.value
        
            print(gamepad.leftThumbstick.xAxis.value)
            print(gamepad.leftThumbstick.yAxis.value)
           
        }
        
        if (gamepad.leftThumbstick.xAxis.value != 0)
        {
        print("Controller: \(index), LeftThumbstickXAxis: \(gamepad.leftThumbstick.xAxis)")
        }
        else if (gamepad.leftThumbstick.xAxis.value == 0)
        {
         
        }
        
        if(gamepad.rightThumbstick == element && index == 0){
            RxVal = gamepad.rightThumbstick.xAxis.value
         
        }
         
        
        // CONTROLLER 2
        if (gamepad.leftThumbstick == element && index == 1)
        {
        
            xVal2 = gamepad.leftThumbstick.xAxis.value
            yVal2 = gamepad.leftThumbstick.yAxis.value
        
           // print(gamepad.leftThumbstick.xAxis.value)
          //  print(gamepad.leftThumbstick.yAxis.value)
           
        }
        
        if (gamepad.leftThumbstick.xAxis.value != 0)
        {
        print("Controller: \(index), LeftThumbstickXAxis: \(gamepad.leftThumbstick.xAxis)")
        }
        else if (gamepad.leftThumbstick.xAxis.value == 0)
        {
         
        }
        
        if(gamepad.rightThumbstick == element && index == 1){
            RxVal2 = gamepad.rightThumbstick.xAxis.value
        }
        
        
        
        
        
        func fireBullet(){

            let vector = rotate(vector: CGVector(dx: 0.25, dy: 0), angle: box.zRotation + rotationOffSet)
            print(vector)
            
            let bullet = SKSpriteNode(color: UIColor.red, size: CGSize(width: 5, height: 5))
            bullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 5))
                   bullet.physicsBody?.affectedByGravity = false
                   bullet.physicsBody?.isDynamic = true
                   bullet.physicsBody?.restitution = 1
                   bullet.physicsBody?.friction = 0
                   bullet.physicsBody?.collisionBitMask = 000010
            bullet.position = box.position
            bullet.physicsBody?.contactTestBitMask = 000010
            bullet.name = "bullet"
            self.addChild(bullet)
            
            
            var actionArray = [SKAction]()
            
            //box top angle + 250 for y
           // actionArray.append(SKAction.move(to: CGPoint(x: Int(box.zRotation) * 100, y: Int(box.zRotation) * 100), duration: 2))
            actionArray.append(SKAction.moveBy(x: vector.dx * 2000, y: vector.dy * 2000, duration: 0.75))
            actionArray.append(SKAction.removeFromParent())
            bullet.run(SKAction.sequence(actionArray))
            
        }
        
        func fireBullet2(){

                   let vector = rotate(vector: CGVector(dx: 0.25, dy: 0), angle: box2.zRotation + rotationOffSet)
                   print(vector)

                    let bullet2 = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 5, height: 5))
            
                    bullet2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 5))
                           bullet2.physicsBody?.affectedByGravity = false
                           bullet2.physicsBody?.isDynamic = true
                           bullet2.physicsBody?.restitution = 1
                           bullet2.physicsBody?.friction = 0
                           bullet2.physicsBody?.collisionBitMask = 000001
                    bullet2.physicsBody?.contactTestBitMask = 000001
                   bullet2.position = box2.position
                    bullet2.name = "bullet2"
                   self.addChild(bullet2)
                 
                   
                   var actionArray = [SKAction]()
                   
                   //box top angle + 250 for y
                  // actionArray.append(SKAction.move(to: CGPoint(x: Int(box.zRotation) * 100, y: Int(box.zRotation) * 100), duration: 2))
                   actionArray.append(SKAction.moveBy(x: vector.dx * 2000, y: vector.dy * 2000, duration: 0.75))
                   actionArray.append(SKAction.removeFromParent())
                   bullet2.run(SKAction.sequence(actionArray))
                   
               }
        
        
        func rotate(vector: CGVector, angle:CGFloat) -> CGVector{
            let rotatedX = vector.dx * cos(angle) - vector.dy * sin(angle)
            let rotatedY = vector.dx * sin(angle) + vector.dy * cos(angle)
            return CGVector(dx: rotatedX, dy: rotatedY)
        }
        
        
        
        if(gamepad.rightTrigger == element && index == 0 && bulletAllowedTime > 35){
                fireBullet()
                print("Bullet Fired")
                bulletAllowedTime = 0
           
        }
        
        if(gamepad.rightTrigger == element && index == 1 && bulletAllowedTime > 35){
                fireBullet2()
                print("Bullet Fired")
                bulletAllowedTime = 0
           
        }
        
        
    }
}
