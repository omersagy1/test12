import Foundation


enum Message {
    case highlightJewel(Jewel)
}


struct Update {

    static func handleMessage(message: Message, model: Model) {
        switch message {
        case .highlightJewel(let jewel):
            highlightJewel(jewel: jewel, model: model)
        }
    }

    static func highlightJewel(jewel: Jewel, model: Model) {
        switch model.state {
        case .awaitingFirstSelection:
            model.select(jewel: jewel)
        case .awaitingSwap(_):
            model.swap(secondJewel: jewel)
        default:
            print("ignoring this jewel tap!")
        }
    }

}
