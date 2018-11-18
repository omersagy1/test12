import Foundation


enum Message {
    case highlightJewel(Jewel) // row, col
}


struct Update {

    static func handleMessage(message: Message, model: Model) {
        switch message {
        case .highlightJewel(let jewel):
            highlightJewel(jewel: jewel, model: model)
        }
    }

    static func highlightJewel(jewel: Jewel, model: Model) {
        guard let pos: (Int, Int) = model.positionOfJewel(jewel) else { return }
        print("touched a \(jewel.type) at \(pos.0),\(pos.1)")
    }

}
