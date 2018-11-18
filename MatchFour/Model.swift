import Foundation
import SpriteKit


struct Model {

    let numRows = 10
    let numCols = 10

    // The grid is laid out like the SpriteKit coordinate system.
    // grid[0][0] is the bottom-left corner.
    var grid: [[Jewel]] = []
    var matchCount: [JewelType: Int] = [:]

    init() {
        for rowIndex in 0..<numRows {
            grid.append(Array())
            for _ in 0..<numCols {
                grid[rowIndex].append(Jewel(type: randomJewelType()))
            }
        }
        for jewel in JewelType.allCases {
            matchCount[jewel] = 0
        }
    }
}


// A GameEntity is an object that can be associated with
// a specific node in the scene tree.
protocol GameEntity {
    var node: SKSpriteNode { get }
}


struct Jewel : GameEntity {

    var node: SKSpriteNode
    var type: JewelType

    init(type: JewelType) {
        self.type = type
        node = SKSpriteNode()
        node.userData = ["modelObject": self]
    }

}


enum JewelType : CaseIterable {
    case emerald
    case topaz
    case sapphire
    case ruby
    case diamond
}


func randomJewelType() -> JewelType {
    return JewelType.allCases.randomElement()!
}
