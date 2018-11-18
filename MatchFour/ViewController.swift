import SpriteKit
import UIKit

class ViewController: UIViewController {

    var gameView: SKView!
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        gameView = view as? SKView
        game = Game(size: gameView.bounds.size)
        game.setUp()
        gameView.presentScene(game)
    }
}
