import Foundation
import SwiftUI

struct MainMenuView : View {
    @ObservedObject var theApp = TheApp.shared
    @State var emailSheetDisplayed: Bool = false
    
    var body: some View {
        MenuBody()
    }
    
    @ViewBuilder
    func MenuBody() -> some View {
        VStack {
            switch theApp.scene {
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
        .animation(.easeInOut, value: theApp.scene)
        .preferredColorScheme(.dark)
    }
    
    func MainMenuView() -> some View {
        VStack(spacing: 50) {
            Text("Choose app mode:")
            
            HStack {
                Button(action: { theApp.scene = .reelsCam } ) { Text("Reels/Pause Camera") }
                
                HelpButt() { HelpReelsView() }
            }
            
            HStack {
                Button(action: { theApp.scene = .teleprompter } ) { Text("Teleprompter") }
                
                HelpButt() { HelpTeleprompterView() }
            }
            
            HStack {
                Button(action: { theApp.scene = .teleprompterCam } ) { Text("Teleprompter + Camera") }
                
                HelpButt() { HelpTeleprompterPlusCamView() }
            }
            
            Button("Support Email") { openMail() }
        }
    }
}

public class TheApp: ObservableObject {
    static let shared = TheApp()
    
    private init() { }
    
    @Published var scene = AppScene.splashScreen
}




////////////////////
///HELPERS
///////////////////
func openMail() {
    openMail(emailTo: "skulptorrr@gmail.com", subject: "VIDEQ: feature request/feedback", body:"Huston, we have a problem!\n\n..")
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
        Text("Give you ability to record set of videos and combine them into single one")
    }
}

struct HelpTeleprompterView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("Created for use iphone/ipad as image source for phisical teleprompters.")
            Text("Example: Parrot Teleprompter")
            
            Image("ParrotTeleprompter1")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 300)
            
            LoopingPlayer(resourceName: "Parrot2", withExtension: "mp4")
                .frame(width: 250, height: 250)
            
            Text("This mode will have absent some useless features for professionas to have more clear design")
        }
    }
}

struct HelpTeleprompterPlusCamView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("Created for use phone as videorecorder and as teleprompter at the same time")
            
            Text("This mode will be most useful for non-professional videoblogers and tiktok users")
        }
    }
}


struct NotImplementedYet: View {
    var body: some  View {
        VStack(spacing: 50) {
            Text("Not implemented Yet")
            
            Button(action: { TheApp.shared.scene = .mainMenu } ) { Text("Back") }
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
            if theApp.scene == .splashScreen {
                theApp.scene = .mainMenu
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
