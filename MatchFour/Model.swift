import Foundation
import SpriteKit


class Model {

    let numRows = 10
    let numCols = 10

    // The grid is laid out like the SpriteKit coordinate system.
    // grid[0][0] is the bottom-left corner.
    var grid: [[Jewel]] = []

    // The number of matched jewels of a particular type.
    // matchCount[.emerald] is the number of emeralds scored
    // through matching.
    var matchCount: [JewelType: Int] = [:]

    var state: GameState = .awaitingFirstSelection

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

    func positionOfJewel(_ jewel: Jewel) -> (Int, Int)? {
        for rowIndex in 0..<numRows {
            for colIndex in 0..<numCols {
                if jewel === grid[rowIndex][colIndex] {
                    return (rowIndex, colIndex)
                }
            }
        }
        return nil
    }
}


enum GameState {

    // We are waiting for the user to pick his first jewel.
    case awaitingFirstSelection

    // We are waiting for the user to pick the jewel to swap.
    // Here we hold a reference to the *first* jewel.
    case awaitingSwap(Jewel)

    // We ignore user input until the animations are complete.
    // This state is entered after we initiate a swap.
    case animating

}


// A GameEntity is an object that can be associated with
// a specific node in the scene tree.
class GameEntity {

    static let modelObjectKey = "modelObject"

    let node = SKSpriteNode()

    init() {
        node.userData = [GameEntity.modelObjectKey: self]
    }

}


class Jewel : GameEntity {

    var type: JewelType

    init(type: JewelType) {
        self.type = type
        super.init()
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
