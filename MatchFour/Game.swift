import Foundation
import SpriteKit


class Game : NSObject, SKSceneDelegate {

    var scene: SKScene

    let label = SKLabelNode(text: "")

    init(scene: SKScene) {
        self.scene = scene
    }

    func setUp() {
        label.position = CGPoint(
            x: scene.size.width / 2,
            y: scene.size.height / 2)
        scene.addChild(label)
    }

    func handleMessage(_ msg: Message) {
        switch msg {
        case .changeLabelText(let newText):
            label.text = newText
        }
    }

}

enum Message {
    case changeLabelText(String)
}
