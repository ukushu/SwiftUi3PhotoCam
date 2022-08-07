import Foundation
import SwiftUI

struct MainMenuView : View {
    @State var scene = AppScene.splashScreen
    
    var body: some View {
        ZStack {
            MenuBody()
            
            if (scene != .splashScreen && scene != .mainMenu) {
                VStack {
                    HStack {
                        BtnBackSmall() { scene = .mainMenu }
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 0))
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    func MenuBody() -> some View {
        VStack {
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
            case .support:
                NotImplementedYet()
            case .splashScreen:
                SplashScreenView()
            }
        }
        .transition(.slide)
        .onAppear { splashScreenDisableIfNeeded() }
        .animation(.easeInOut, value: scene)
        .preferredColorScheme(.dark)
    }
    
    func MainMenuView() -> some View {
        VStack(spacing: 50) {
            Text("Choose app mode:")
            
            HStack {
                Button(action: { scene = .reelsCam } ) { Text("Reels/Pause Camera") }
                
                HelpButt() { Text("Give you ability to record lot of videos and combine them into single one") }
            }
            
            Button(action: { scene = .teleprompter } ) { Text("Teleprompter") }
            
            Button(action: { scene = .teleprompterCam } ) { Text("Teleprompter + Camera") }
            
            Button(action: { scene = .support } ) { Text("Contact Support") }
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
    case support
    case splashScreen
}


////////////////////
///HELPERS
////////////////////

fileprivate extension MainMenuView {

    func splashScreenDisableIfNeeded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            if scene == .splashScreen {
                scene = .mainMenu
            }
        }
    }
}

fileprivate struct SplashScreenView : View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("StartScreenLogo")
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        .background(.white)
    }
}
