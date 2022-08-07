//
//  Teleprompter.swift
//  PCam
//
//  Created by UKS on 06.08.2022.
//

import Foundation
import SwiftUI

struct TeleprompterView: View {
    @ObservedObject var model: TeleprompterViewModel
    
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    
    @State var editMode = false
    
    var body: some View {
        VStack(spacing:0) {
            if model.mirrorYAxis {
                TeleprompterBodyView()
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            } else {
                TeleprompterBodyView()
            }
        }
        .onAppear() { autoScroll() }
    }
}

extension TeleprompterView {
    func TeleprompterBodyView() -> some View {
        VStack{
            if editMode {
                TextEditor(text: $model.text)
                
                TeleprompterEditModeBtnsPanel()
            } else {
                Text(model.text)
                    .font(.system(size: model.textSize))
                    .foregroundColor(model.textColor)
                    .padding(.top, Globals.teleprompterSafeArea)
                    .padding(.bottom, 500)
                    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.01))
                    .fixedSize(horizontal: false, vertical: true)
                    .offset( x: 0, y: model.position.y + model.dragOffset.y )
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                model.userDragging = true
                                model.dragOffset.y = gesture.translation.height
                            }
                            .onEnded { gesture in
                                model.userDragging = false
                                model.position.y = model.position.y + gesture.translation.height
                                
                                if model.position.y > Globals.teleprompterSafeArea {
                                    model.position.y = Globals.teleprompterSafeArea
                                }
                                
                                model.dragOffset = .zero
                            }
                    )
                    .padding(.horizontal, 7)
                    .padding(.horizontal, model.marginsH)
            }
        }
        .gesture(
            SimultaneousGesture(TapGesture(count: 1), TapGesture(count: 2))
                .onEnded { gestureValue in
                    if gestureValue.second != nil {
                        editMode.toggle()
                    } else if gestureValue.first != nil {
                        model.displaySettings = false
                    }
                }
        )
        .animation(.easeInOut, value: editMode)
        .padding(.bottom, keyboardHeightHelper.keyboardHeight)
    }
    
    func TeleprompterEditModeBtnsPanel() -> some View {
        HStack (spacing: 40){
            Button(action: { editMode.toggle(); model.position.y = Globals.teleprompterSafeArea } )
                { SuperBtnLabel(text: "Close", icon: "xmark.circle.fill") }
            
            Button(action: { model.text = "" } )
                { SuperBtnLabel(text: "Clear", icon: "doc") }
            
            Button(action: { pasteboardPaste() } )
                { SuperBtnLabel(text: "Paste", icon: "arrowshape.turn.up.left.fill") }
        }
        .padding(.bottom, 20)
    }
}

extension View {
    func teleprompterMini(bgOpacity: CGFloat) -> some View {
        self.background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: bgOpacity))
            .frame(height: 350, alignment: .top)
            .clipShape(Rectangle())
            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom) )
            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .clear]), startPoint: .top, endPoint: .bottom) )
            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .clear]), startPoint: .top, endPoint: .bottom) )
    }
    
    func teleprompterMaxi(height: CGFloat) -> some View  {
        self.frame(height: height, alignment: .top)
            .clipShape(Rectangle())
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
                if model.position.y < Globals.teleprompterSafeArea - 10 && !model.userDragging {
                    model.position.y -= model.speed
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
            if model.text.count > 0 {
                model.text += "\r\(str)"
            } else {
                model.text = str
            }
        }
    }
}
