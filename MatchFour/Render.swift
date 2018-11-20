import Foundation
import SpriteKit


// Renders the entire scene from a single root node.
func render(model: Model, sceneSize: CGSize) -> SKNode {
    let root = SKNode()
    let spacing = renderConstants.spacing
    let sideLength = renderConstants.sideLength

    let offset = gridOffset(
        sceneSize: sceneSize,
        numRows: model.numRows,
        numCols: model.numCols,
        sideLength: Double(sideLength),
        spacing: Double(spacing))

    for (rowIndex, row) in model.grid.enumerated() {
        for (colIndex, jewel) in row.enumerated() {
            let jewelPos = add(
                p1: offset,
                p2: CGPoint(x: (sideLength + spacing) * rowIndex,
                            y: (sideLength + spacing) * colIndex))

            renderJewel(jewel)
            jewel.node.position = jewelPos
            root.addChild(jewel.node)
        }
    }
    return root
}


func renderJewel(_ jewel: Jewel) {

    // Render the jewel from scratch.
    jewel.node.removeAllChildren()

    if !jewel.isSelected() {
        let coloredSquare = SKSpriteNode()
        coloredSquare.color = jewelColor(jewel.type)
        coloredSquare.size = CGSize(width: renderConstants.sideLength,
                                 height: renderConstants.sideLength)
        jewel.node.addChild(coloredSquare)
    } else {
        let frameNode = SKSpriteNode()
        frameNode.color = .yellow
        frameNode.size = CGSize(width: renderConstants.sideLength,
                                height: renderConstants.sideLength)

        let coloredSquare = SKSpriteNode()
        coloredSquare.color = jewelColor(jewel.type)
        coloredSquare.size = CGSize(width: renderConstants.sideLength - 5,
                                    height: renderConstants.sideLength - 5)

        jewel.node.addChild(frameNode)
        frameNode.addChild(coloredSquare)
    }
}


func jewelColor(_ jewel: JewelType) -> UIColor {
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

    return CGPoint(x: xOffset, y: yOffset)
}


func add(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}


struct renderConstants {
    static let spacing = 5  // px
    static let sideLength = 45
}

