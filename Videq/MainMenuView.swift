import Foundation
import SwiftUI

struct MainMenuView : View {
    @State var scene = AppScene.splashScreen
    @State var emailSheetDisplayed: Bool = false
    
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
                SceneTelepromterVideoCam()
                    .background(Color(red: 0, green: 0, blue: 0.01, opacity: 0.01))
            case .reelsCam:
                ScenePauseCam()
            case .teleprompter:
                SceneTeleprompter()
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
                
                HelpButt() { HelpReelsView() }
            }
            
            HStack {
                Button(action: { scene = .teleprompter } ) { Text("Teleprompter") }
                
                HelpButt() { HelpTeleprompterView() }
            }
            
            HStack {
                Button(action: { scene = .teleprompterCam } ) { Text("Teleprompter + Camera") }
                
                HelpButt() { HelpTeleprompterPlusCamView() }
            }
            
            Button("Support Email") { openMail() }
        }
    }
}


////////////////////
///HELPERS
///////////////////
func openMail() {
    openMail(emailTo: "skulptorrr@gmail.com", subject: "VIDEOQ: feature request/feedback", body:"Huston, we have a problem!\n\n..")
}

func openMail(emailTo:String, subject: String, body: String) {
    if let url = URL(string: "mailto:\(emailTo)?subject=\(subject.fixToBrowserString())&body=\(body.fixToBrowserString())"),
       UIApplication.shared.canOpenURL(url)
    {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension String {
    func fixToBrowserString() -> String {
        self.replacingOccurrences(of: ";", with: "%3B")
            .replacingOccurrences(of: "\n", with: "%0D%0A")
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: "!", with: "%21")
            .replacingOccurrences(of: "\"", with: "%22")
            .replacingOccurrences(of: "\\", with: "%5C")
            .replacingOccurrences(of: "/", with: "%2F")
            .replacingOccurrences(of: "‘", with: "%91")
            .replacingOccurrences(of: ",", with: "%2C")
            //more symbols fixes here: https://mykindred.com/htmlspecialchars.php
    }
}


struct HelpReelsView: View {
    var body: some View {
        Text("Give you ability to record lot of videos and combine them into single one")
    }
}

struct HelpTeleprompterView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("Created for use with phisical teleprompters that uses phone as screen.\nLike a \"Parrot Teleprompter\"")
            
            Image("ParrotTeleprompter1")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 300)
        }
    }
}

struct HelpTeleprompterPlusCamView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("Created for use phone as videorecorder and as teleprompter both")
        }
    }
}


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
    //case support
    case splashScreen
}


////////////////////
///HELPERS
////////////////////

fileprivate extension MainMenuView {

    func splashScreenDisableIfNeeded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            if scene == .splashScreen {
                scene = .mainMenu
            }
        }
    }
}

fileprivate struct SplashScreenView : View {
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Spacer()
                
                Image("StartScreenLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 130)
                
                Spacer()
            }
            
            Spacer()
        }
        .background(.black)
    }
}
