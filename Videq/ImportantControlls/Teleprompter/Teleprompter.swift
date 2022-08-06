//
//  Teleprompter.swift
//  PCam
//
//  Created by UKS on 06.08.2022.
//

import Foundation
import SwiftUI

struct TeleprompterView: View {
    @ObservedObject var telepVm: TeleprompterViewModel
    
    @State var displaySettings = false
    @State var editMode = false
    
    var body: some View {
        VStack(spacing:0) {
            TeleprompterBodyView ()
                .frame(height: 350, alignment: .top)
            
            SettingsView()
        }
        .animation(.easeInOut, value: displaySettings)
        .onAppear() { autoScroll() }
    }
}

extension TeleprompterView {
    func TeleprompterBodyView() -> some View {
        VStack {
            if editMode {
                VStack {
                    TextEditor(text: $telepVm.text)
                    
                    TeleprompterEditModeBtnsPanel()
                }
            } else {
                Text(telepVm.text)
                    .font(.system(size: telepVm.textSize))
                    .frame(width: UIScreen.screenWidth - 7)
                    .foregroundColor(telepVm.textColor)
                    .padding(.top, Globals.teleprompterSafeArea)
                    .padding(.bottom, 500)
                    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.01))
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
                                
                                if telepVm.position.y > Globals.teleprompterSafeArea {
                                    telepVm.position.y = Globals.teleprompterSafeArea
                                }
                                
                                telepVm.dragOffset = .zero
                            }
                    )
                    .padding(.horizontal, 7)
            }
        }
        .frame(height: 350, alignment: .top)
        .clipShape(Rectangle())
        .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: telepVm.bgOpacity))
        .onTapGesture(count: 2) { withAnimation{ editMode.toggle() } }
        .animation(.easeInOut, value: editMode)
    }
    
    func TeleprompterEditModeBtnsPanel() -> some View {
        HStack (spacing: 40){
            Button(action: { editMode.toggle(); telepVm.position.y = Globals.teleprompterSafeArea } )
                { SuperBtnLabel(text: "Close", icon: "xmark.circle.fill") }
            
            Button(action: { telepVm.text = "" } )
                { SuperBtnLabel(text: "Clear", icon: "doc") }
            
            Button(action: { pasteboardPaste() } )
                { SuperBtnLabel(text: "Paste", icon: "arrowshape.turn.up.left.fill") }
        }
        .padding(.bottom, 10)
    }
}

extension TeleprompterView {
    
    @ViewBuilder
    func SettingsView() -> some View {
        if displaySettings {
            VStack {
                VStack {
                    HStack{
                        SpeedSlider()
                        BtnSettings()
                            .id("BtnSettings")
                            .padding(.leading, 10)
                    }
                    
                    HStack {
                        TextSizeSlider()
                        
                        ColorPicker(selection: $telepVm.textColor) { EmptyView() }
                            .frame(width: 25)
                            .padding(.trailing, 5)
                            .padding(.leading, 10)
                    }
                    
                    BgOpacitySlider()
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 15)
            .background(Color(red: 0, green: 0, blue: 0, opacity: 0.7))
        } else {
            HStack {
                Spacer()
                BtnSettings()
                    .padding(10)
                    .id("BtnSettings")
            }
        }
    }
}

struct SuperBaseBtnLabel : View {
    let text: String
    let icon: String
    
    var body: some View {
        Label {
            Text(text)
                .foregroundColor(.orange)
        } icon: {
            Image (systemName : icon)
                .foregroundColor(.orange)
        }
    }
}

struct SuperBtnLabel : View {
    let text: String
    let icon: String
    
    var body: some View {
        Label {
            Text(text)
                .foregroundColor(.orange)
        } icon: {
            Image (systemName : icon)
                .foregroundColor(.orange)
        }
        .padding(7)
        .background{
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(UIColor.systemGray))
        }
    }
}




////////////////////
///HELPERS
////////////////////
extension TeleprompterView {
    func autoScroll() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation{
                if telepVm.position.y < Globals.teleprompterSafeArea - 10 && !telepVm.userDragging {
                    telepVm.position.y -= telepVm.speed
                }
            }
            
            autoScroll()
        }
    }
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension TeleprompterView {
    func pasteboardPaste() {
        if let str = UIPasteboard.general.string{
            if telepVm.text.count > 0 {
                telepVm.text += "\r\(str)"
            } else {
                telepVm.text = str
            }
        }
    }
}
