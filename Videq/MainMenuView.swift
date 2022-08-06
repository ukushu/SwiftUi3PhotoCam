import Foundation
import SwiftUI

struct MainMenuView : View {
    @State var scene = AppScene.mainMenu
    
    var body: some View {
        switch scene {
        case .mainMenu:
            MainMenuView()
        case .teleprompterCam:
            TelepromterVideoCamView()
                .background(Color(red: 0, green: 0, blue: 0.01, opacity: 0.01))
        case .reelsCam:
            NotImplementedYet()
        case .teleprompter:
            TeleprompterSceneView()
        }
    }
    
    func MainMenuView() -> some View {
        VStack(spacing: 50) {
            Text("Choose app mode:")
            
            Button(action: { scene = .reelsCam } ) { Text("Reels/Pause Camera") }
            
            Button(action: { scene = .teleprompter } ) { Text("Teleprompter") }
            
            Button(action: { scene = .teleprompterCam } ) { Text("Teleprompter + Camera") }
        }
    }
}


////////////////////
///HELPERS
///////////////////

extension MainMenuView {
    func NotImplementedYet() -> some  View {
        VStack(spacing: 50) {
            Text("Not implemented Yet")
            
            Button(action: { scene = .mainMenu } ) { Text("Back") }
        }
    }
}

enum AppScene {
    case reelsCam
    case teleprompter
    case teleprompterCam
    case mainMenu
}
