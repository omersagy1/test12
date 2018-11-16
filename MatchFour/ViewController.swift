import SpriteKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameView: SKView!
    @IBOutlet weak var labelInput: UITextField!

    var scene: GameScene!

    let label = SKLabelNode(text: "SpriteKit")

    override func viewDidLoad() {
        super.viewDidLoad()

        scene = GameScene(
            size: CGSize(
                width: gameView.frame.width,
                height: gameView.frame.height))

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


class GameScene : SKScene {

}
