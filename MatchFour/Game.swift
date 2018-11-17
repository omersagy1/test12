import Foundation
import SpriteKit


class Game : NSObject, SKSceneDelegate {

    var scene: SKScene
    var model = Model()

    init(scene: SKScene) {
        self.scene = scene
    }

    func setUp() {
        let view = render(model: model, sceneSize: scene.size)
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

    // The grid is laid out like the SpriteKit coordinate system.
    // grid[0][0] is the bottom-left corner.
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

// Renders the entire scene from a single root node.
func render(model: Model, sceneSize: CGSize) -> SKNode {
    let root = SKNode()

    let offset = gridOffset(
        sceneSize: sceneSize,
        numRows: model.numRows,
        numCols: model.numCols,
        sideLength: Double(sideLength),
        spacing: Double(spacing))


    for (rowIndex, row) in model.grid.enumerated() {
        for (colIndex, jewel) in row.enumerated() {
            let rect = SKSpriteNode(
                color: jewelColor(jewel),
                size: CGSize(width: sideLength,
                             height: sideLength))

            rect.position = add(
                p1: offset,
                p2: CGPoint(x: (sideLength + spacing) * rowIndex,
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


func gridOffset(
    sceneSize: CGSize,
    numRows: Int,
    numCols: Int,
    sideLength: Double,
    spacing: Double) -> CGPoint {

    let gridWidth = Double(numRows) * sideLength + Double(numRows - 1) * spacing
    let xOffset = (Double(sceneSize.width) - gridWidth) / 2.0 + sideLength / 2.0

    let gridHeight = Double(numCols) * sideLength + Double(numCols - 1) * spacing
    let yOffset = (Double(sceneSize.height) - gridHeight) / 2.0

    print("x-offset \(xOffset)")
    print(yOffset)

    return CGPoint(x: xOffset, y: yOffset)
}


func add(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}
