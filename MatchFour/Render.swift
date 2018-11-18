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
            jewel.node.color = jewelColor(jewel.type)
            jewel.node.size = CGSize(width: sideLength, height: sideLength)
            jewel.node.position = add(
                p1: offset,
                p2: CGPoint(x: (sideLength + spacing) * rowIndex,
                            y: (sideLength + spacing) * colIndex))
            root.addChild(jewel.node)
        }
    }
    return root
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
    static let spacing = 4  // px
    static let sideLength = 30
}
