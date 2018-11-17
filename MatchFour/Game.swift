import Foundation
import SpriteKit


class Game : NSObject, SKSceneDelegate {

    var scene: SKScene
    var model = Model()

    init(scene: SKScene) {
        self.scene = scene
    }

    func setUp() {
        let view = render(model: model)
        scene.addChild(view)
    }

    func handleMessage(_ msg: Message) {
        switch msg {
        case .changeLabelText(_):
            _ = 1
        }
    }

}


struct Model {

    let numRows = 10
    let numCols = 10

    var grid: [[Jewel]] = []
    var matchCount: [Jewel: Int] = [:]

    init() {
        for rowIndex in 0..<numRows {
            grid.append(Array())
            for _ in 0..<numCols {
                grid[rowIndex].append(randomJewel())
            }
        }
        for jewel in Jewel.allCases {
            matchCount[jewel] = 0
        }
    }
}


enum Jewel : CaseIterable {
    case emerald
    case topaz
    case sapphire
    case ruby
    case diamond
}

func randomJewel() -> Jewel {
    return Jewel.allCases.randomElement()!
}


enum Message {
    case changeLabelText(String)
}


let spacing = 4  // px
let sideLength = 30
let offset = CGPoint(x: 40, y: 150)

// Renders the entire scene from a single root node.
func render(model: Model) -> SKNode {
    let root = SKNode()

    for (rowIndex, row) in model.grid.enumerated() {
        for (colIndex, jewel) in row.enumerated() {
            let rect = SKSpriteNode(
                color: jewelColor(jewel),
                size: CGSize(width: sideLength,
                             height: sideLength))

            rect.position = addPoints(
                offset,
                CGPoint(x: (sideLength + spacing) * rowIndex,
                        y: (sideLength + spacing) * colIndex))

            root.addChild(rect)
        }
    }
    return root
}


func jewelColor(_ jewel: Jewel) -> UIColor {
    switch jewel {
    case .diamond:
        return .white
    case .emerald:
        return .green
    case .ruby:
        return .red
    case .sapphire:
        return .blue
    case .topaz:
        return .orange
    }
}


func addPoints(_ p1: CGPoint, _ p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}
