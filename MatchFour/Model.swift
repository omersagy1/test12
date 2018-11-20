import Foundation
import SpriteKit


class Model {

    let numRows = 8
    let numCols = 8

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

    func select(jewel: Jewel) {
        self.state = .awaitingSwap(jewel)
        jewel.select()
    }

    func swap(secondJewel: Jewel) {
        switch self.state {
        case .awaitingSwap(let firstJewel):
            guard let pos1: (Int, Int) = positionOfJewel(firstJewel) else { return }
            guard let pos2: (Int, Int) = positionOfJewel(secondJewel) else { return }
            if abs(pos1.0 - pos2.0) + abs(pos1.1 - pos2.1) <= 1 {
                self.grid[pos1.0][pos1.1] = secondJewel
                self.grid[pos2.0][pos2.1] = firstJewel

                let gpos1 = firstJewel.node.position
                firstJewel.node.position = secondJewel.node.position
                secondJewel.node.position = gpos1

                self.state = .awaitingFirstSelection
                firstJewel.deselect()
                secondJewel.deselect()
            } else {
                // If we can't swap with the second jewel, we should select
                // it and it will become the new 'first' jewel.
                firstJewel.deselect()
                self.select(jewel: secondJewel)
            }
        default:
            break
        }
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

    // Every game entity is a tree of nodes. This
    // name allows us to identify the root node.
    static let rootNodeName = "entityRoot"

    let node = SKNode()

    init() {
        node.name = GameEntity.rootNodeName
        node.userData = [GameEntity.modelObjectKey: self]
    }

}


class Jewel : GameEntity {

    let type: JewelType
    private var selected: Bool = false

    init(type: JewelType) {
        self.type = type
        super.init()
    }

    func select() {
        selected = true
        renderJewel(self)
    }

    func deselect() {
        selected = false
        renderJewel(self)
    }

    func isSelected() -> Bool {
        return self.selected
    }

}


enum JewelType : CaseIterable {
    case emerald
    case topaz
    case sapphire
    case ruby
    case diamond
    case amethyst
}


func randomJewelType() -> JewelType {
    return JewelType.allCases.randomElement()!
}
