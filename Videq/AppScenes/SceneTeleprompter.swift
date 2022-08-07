//
//  TelepromterView.swift
//  Videq
//
//  Created by UKS on 06.08.2022.
//

import Foundation
import SwiftUI

struct SceneTeleprompter: View {
    @ObservedObject var model = TeleprompterViewModel(miniMode: false)
    
    var body: some View {
        ZStack {
            TeleprompterView(model: model)
                .teleprompterMaxi(height: UIScreen.screenHeight)
            
            HeaderBgLine()
            
            SettingsBtn()
            
            BackToMainMenuBtn()
            
            VStack {
                Spacer()
                
                TeleprompterSettingsView(model: model)
                    .padding(.bottom, 20)
            }
        }
        .background(Color.black)
    }
}

extension SceneTeleprompter {
    func SettingsBtn() -> some View {
        VStack {
            HStack {
                Spacer()
                
                TeleprompterSettingsBtn(displaySettings: $model.displaySettings)
                    .padding(.trailing, 15)
                    .padding(.top, 5)
            }
            Spacer()
        }
    }
}
