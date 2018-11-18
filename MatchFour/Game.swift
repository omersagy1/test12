import Foundation
import SpriteKit


class Game : SKScene {

    var model = Model()

    func setUp() {
        let view = render(model: model, sceneSize: self.size)
        self.addChild(view)
    }

    func handleMessage(_ msg: Message) {
        switch msg {
        case .highlightJewel(let row, let col):
            self.highlightJewel(row, col)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        guard let node = self.nodes(at: location).first else { return }
        guard let row: Int = node.userData?["row"] as? Int else { return }
        guard let col: Int = node.userData?["col"] as? Int else { return }
        handleMessage(.highlightJewel(row, col))
    }

    func highlightJewel(_ row: Int, _ col: Int) {
        print("touched jewel at \(row), \(col)")
    }

}





