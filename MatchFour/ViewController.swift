import SpriteKit
import UIKit

class ViewController: UIViewController {

    var gameView: SKView!
    var game: Game!
    var scene: SKScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        gameView = view as? SKView

        scene = SKScene(size: gameView.bounds.size)
        game = Game(scene: scene)

        scene.delegate = game

        game.setUp()
        gameView.presentScene(scene)
    }

    @IBAction func labelChanged(_ sender: UITextField) {
        guard let newText = sender.text else {
            return
        }
        game.handleMessage(.changeLabelText(newText))
        view.endEditing(true)
    }
}
