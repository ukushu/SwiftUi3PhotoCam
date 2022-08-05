import SwiftUI
import AVFoundation
import Foundation
import Introspect

struct VideoCamView: View {
    @Binding var isPhotoMode: Bool
    
    @StateObject var camera = CameraModel()
    
    @ObservedObject var telepVm = TeleprompterViewModel()
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Spacer()
                    BtnPhotoVideoSwitcher(isPhotoMode: $isPhotoMode)
                }
                
                VStack{
                    Text(reallyLargeText)
                        .font(.system(size: telepVm.textSize))
                        .foregroundColor(telepVm.color)
                        .padding(.top, 50)
                        .padding(.bottom, 500)
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
                                    
                                    if telepVm.position.y > 50 {
                                        telepVm.position.y = 50
                                    }
                                    
                                    telepVm.dragOffset = .zero
                                }
                        )
                }
                .frame(height: 500, alignment: .top)
                .clipShape(Rectangle())
                
                Divider()
                
                Text("offset: \(telepVm.position.y) | \(telepVm.position.y + telepVm.dragOffset.y) |")
                
                Spacer()
            }
        }
        .onAppear(){
            callFunc()
        }
    }
    
    func callFunc() {
        print("callFunc()")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation{
                if telepVm.position.y < telepVm.textSize * 2 && !telepVm.userDragging {
                    telepVm.position.y -= telepVm.speed
                }
            }
            
            callFunc()
        }
    }
}

class TeleprompterViewModel: ObservableObject {
    @Published var dragOffset: CGPoint = .zero
    @Published var position: CGPoint = CGPoint(x: 0, y: 50)
    
    @Published var textSize: CGFloat = 20
    @Published var color: Color = .yellow
    
    // 2 - 7/ 2 is slowest speed
    @Published var speed: CGFloat = 0.7
    
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
