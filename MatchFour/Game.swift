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

        // nodes(at:) uses calculateAccumulatedFrame to find nodes that
        // have been intersected. This means the GameEntity's root node will
        // always be included if one of its children has been touched.
        let touchedNodes = self.nodes(at: location)

        var entityTouched: GameEntity?
        for node in touchedNodes {
            if node.name == GameEntity.rootNodeName {
                entityTouched = node.userData?[GameEntity.modelObjectKey] as? GameEntity
            }
        }

        // Only Jewels react to touches.
        guard let jewel = entityTouched as? Jewel else { return }

        Update.handleMessage(message: .highlightJewel(jewel), model: model)
    }
}
