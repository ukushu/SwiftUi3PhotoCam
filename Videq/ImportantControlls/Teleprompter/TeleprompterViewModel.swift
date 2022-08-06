import Foundation
import SwiftUI

class TeleprompterViewModel: ObservableObject {
    @Published var displaySettings = false
    @Published var miniMode: Bool
    
    @Published var mirrorYAxis: Bool = false
    @Published var marginsH: CGFloat = 0
    
    @Published var dragOffset: CGPoint = .zero
    @Published var position: CGPoint = CGPoint(x: 0, y: 60)
    
    @Published(key: "textSize") var textSize: CGFloat = 20
    @Published var textColor: Color = .yellow
    
    @Published(key: "telepText") var text: String = Globals.defaultText
    
    @Published(key: "telepSpeed") var speed: CGFloat = 0.7
    //@Published var lastSpeed: CGFloat = 0.7
    
    @Published(key: "bgOpacity")  var bgOpacity: CGFloat = 0.2
    
    @Published var userDragging: Bool = false
    
    init(miniMode: Bool) {
        _miniMode = Published(initialValue: miniMode)
    }
}
