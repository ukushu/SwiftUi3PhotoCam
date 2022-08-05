import SwiftUI
import AVFoundation
import Foundation
import Introspect

struct VideoCamView: View {
    @Binding var isPhotoMode: Bool
    
    @StateObject var camera = CameraModel()
    
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Spacer()
                    BtnPhotoVideoSwitcher(isPhotoMode: $isPhotoMode)
                }
                
                TeleprompterView()
                    .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
                
                Spacer()
            }
        }
    }
}

struct TeleprompterView: View {
    @ObservedObject var telepVm = TeleprompterViewModel()
    
    @State var displaySettings = false
    @State var editMode = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    TeleprompterView()
                }
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        
                        Button(action: { displaySettings.toggle() }) {
                            Image(systemName: "gear")
                        }
                        .padding( 5)
                    }
                }
            }
            
            if displaySettings {
                SettingsView()
                    .padding(.vertical)
                    .padding(.horizontal, 15)
            }
        }
        .frame(height: 350, alignment: .top)
        .onAppear(){
            autoScroll()
        }
    }
    
    func TeleprompterView() -> some View {
        VStack {
            if editMode {
                VStack {
                    TextEditor(text: $telepVm.text)
                    
                    HStack (spacing: 20){
                        Button(action: { editMode.toggle(); telepVm.position.y = 60 } ) { Text("Close") }
                        Button(action: { telepVm.text = "" } ) { Text("Clear") }
                        //Button(action: { telepVm.text = "" } ) { Text("Paste") }
                    }
                }
            } else {
                Text(telepVm.text)
                    .font(.system(size: telepVm.textSize))
                    .frame(width: UIScreen.screenWidth - 7)
                    .foregroundColor(telepVm.color)
                    .padding(.top, 60)
                    .padding(.bottom, 500)
                    .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.1))
                    .fixedSize(horizontal: false, vertical: true)
                    .offset( x: 0, y: telepVm.position.y + telepVm.dragOffset.y )
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                telepVm.userDragging = true
                                telepVm.dragOffset.y = gesture.translation.height
                            }
                            .onEnded { gesture in
                                telepVm.userDragging = false
                                telepVm.position.y = telepVm.position.y + gesture.translation.height
                                
                                if telepVm.position.y > 60 {
                                    telepVm.position.y = 60
                                }
                                
                                telepVm.dragOffset = .zero
                            }
                    )
            }
        }
        .frame(height: 350, alignment: .top)
        .clipShape(Rectangle())
        .padding(.horizontal, 7)
        .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.1))
        .onTapGesture(count: 2) { editMode.toggle() }
    }
    
    func SettingsView() -> some View {
        VStack {
            VStack {
                SpeedSlider()
                
                HStack {
                    ColorPicker(selection: $telepVm.color) { EmptyView() }
                        .frame(width: 25)
                        .padding(.trailing, 5)
                    
                    TextSizeSlider()
                }
            }
        }
    }
}

extension TeleprompterView {
    func autoScroll() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation{
                if telepVm.position.y < telepVm.textSize * 2 && !telepVm.userDragging {
                    telepVm.position.y -= telepVm.speed
                }
            }
            
            autoScroll()
        }
    }
}

extension TeleprompterView {
    func SpeedSlider() -> some View {
        HStack {
            Text(Image(systemName: "tortoise"))
            
            BoundsSlider(min: 0.7, max: 5, value: $telepVm.speed)
            
            Text(Image(systemName: "hare"))
        }
        
    }
    
    func TextSizeSlider() -> some View {
        HStack {
            Text("a")
                .font(.system(size: 20))
            
            BoundsSlider(min: 15, max: 30, value: $telepVm.textSize)
            
            Text("A")
                .font(.system(size: 20))
        }
    }
    
}

class TeleprompterViewModel: ObservableObject {
    @Published var dragOffset: CGPoint = .zero
    @Published var position: CGPoint = CGPoint(x: 0, y: 60)
    
    @Published var textSize: CGFloat = 20
    @Published var color: Color = .yellow
    
    @Published var text: String = reallyLargeText
    
    @Published var speed: CGFloat = 0.7
    //@Published var lastSpeed: CGFloat = 0.7
    
    @Published var userDragging: Bool = false
}

let reallyLargeText =
"""
Written in SwiftUI 3, so plist file is absent (plist is accessible in project settings)

For some reason not always capture/save new image, have no idea why (not able to save in case it is not captures)

But you can hear when image is not captured - there is no "photo sound"

Photo part is based on videotutorial: https://www.youtube.com/watch?v=8hvaniprctk but code is not the same

VideoRecorder part is based on: https://www.youtube.com/watch?v=_GGDueorwEA
Written in SwiftUI 3, so plist file is absent (plist is accessible in project settings)

For some reason not always capture/save new image, have no idea why (not able to save in case it is not captures)

But you can hear when image is not captured - there is no "photo sound"

Photo part is based on videotutorial: https://www.youtube.com/watch?v=8hvaniprctk but code is not the same

VideoRecorder part is based on: https://www.youtube.com/watch?v=_GGDueorwEA
Written in SwiftUI 3, so plist file is absent (plist is accessible in project settings)

For some reason not always capture/save new image, have no idea why (not able to save in case it is not captures)

But you can hear when image is not captured - there is no "photo sound"

Photo part is based on videotutorial: https://www.youtube.com/watch?v=8hvaniprctk but code is not the same

VideoRecorder part is based on: https://www.youtube.com/watch?v=_GGDueorwEA
Written in SwiftUI 3, so plist file is absent (plist is accessible in project settings)

For some reason not always capture/save new image, have no idea why (not able to save in case it is not captures)

But you can hear when image is not captured - there is no "photo sound"

Photo part is based on videotutorial: https://www.youtube.com/watch?v=8hvaniprctk but code is not the same

VideoRecorder part is based on: https://www.youtube.com/watch?v=_GGDueorwEA
"""

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
