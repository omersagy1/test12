import Foundation
import SpriteKit


class Game : SKScene {

    var model = Model()

    func setUp() {
        let view = render(model: model, sceneSize: self.size)
        self.addChild(view)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        guard let node = self.nodes(at: location).first else { return }
        guard let jewel = node.userData?[GameEntity.modelObjectKey] as? Jewel else { return }

        Update.handleMessage(message: .highlightJewel(jewel), model: model)
    }
}
