//
//  ViewController.swift
//  MatchFour
//
//  Created by Omer Sagy on 11/15/18.
//  Copyright © 2018 Omer Sagy. All rights reserved.
//

import SpriteKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameView: SKView!
    @IBOutlet weak var labelInput: UITextField!

    let scene = SKScene(
        size: CGSize(width: 277, height: 262))

    let label = SKLabelNode(text: "SpriteKit")

    override func viewDidLoad() {
        super.viewDidLoad()
        label.position = CGPoint(
            x: scene.size.width / 2,
            y: scene.size.height / 2)
        scene.addChild(label)

        render()
    }

    @IBAction func labelChanged(_ sender: UITextField) {
        label.text = sender.text
        view.endEditing(true)
        render()
    }

    func render() {
        gameView.presentScene(scene)
    }
}

