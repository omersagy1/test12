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
        case .highlightJewel(let jewel):
            self.highlightJewel(jewel)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        guard let node = self.nodes(at: location).first else { return }
        guard let jewel = node.userData?["modelObject"] as? Jewel else { return }

        handleMessage(.highlightJewel(jewel))
    }

    func highlightJewel(_ jewel: Jewel) {
        print("touched a \(jewel.type)")
    }

}





