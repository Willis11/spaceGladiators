//
//  GameViewController.swift
//  ps4ControllerGame
//
//  Created by Jude Willis on 31/07/2020.
//  Copyright © 2020 Jude Willis. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
                let scene = startScene(size: CGSize(width: 400, height: 600))
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
           
                
                // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
