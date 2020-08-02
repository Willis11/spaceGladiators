//
//  startScene.swift
//  ps4ControllerGame
//
//  Created by Jude Willis on 02/08/2020.
//  Copyright © 2020 Jude Willis. All rights reserved.
//

import Foundation
import GameKit

class startScene : SKScene{
    
    var titleLabel = SKLabelNode(fontNamed: "Futura Bold")
    var startLabel = SKLabelNode(fontNamed: "Futura Bold")
    var countUpdateTime : Int = 0
    var runningTime : Int = 0
    
    var startButton = SKSpriteNode(color: UIColor.purple, size: CGSize(width: 200, height: 75))
    
    override func didMove(to view: SKView) {
        titleLabel.position = CGPoint(x: 0, y: 250)
        titleLabel.text = "Space Gladiators"
        titleLabel.fontSize = 38
        addChild(titleLabel)
        
        startButton.position = CGPoint(x: 0, y: 0)
        addChild(startButton)
        
        startLabel.position = CGPoint(x: 0, y: -10)
        startLabel.text = "Start"
        startLabel.fontSize = 32
        addChild(startLabel)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return print("error") }
        if(startButton.frame.contains(location)){
            let newScene = GameScene(size: CGSize(width: 400, height: 600))
            newScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            newScene.scaleMode = .resizeFill
            let animation = SKTransition.fade(withDuration: 1)
          view?.presentScene(newScene, transition: animation)
        }
    }
    
}
