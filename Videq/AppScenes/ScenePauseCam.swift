//
//  PauseCam.swift
//  Videq
//
//  Created by UKS on 07.08.2022.
//

import Foundation
import SwiftUI

struct ScenePauseCam: View {
    @StateObject var camera = CameraModel()
    
    @State var zaglushka = true
    
    var body: some View {
        ZStack {
            CameraView()
                .environmentObject(camera)
            
            if let _ = camera.previewURL, camera.showPreview { } else {
                HeaderBgLine()
                
                SettingsBtns()
            }
            
            CameraControlsView()
                .environmentObject(camera)
            
            if let url = camera.previewURL, camera.showPreview {
                VideoPreview(model: camera)
                    .transition(.move (edge:.trailing))
                    
            } else {
                BackToMainMenuBtn()
            }
            
        }
    }
}

extension ScenePauseCam {
    func SettingsBtns() -> some View {
        VStack {
            HStack {
                Spacer()
                
                VideoCamSettingsBtn(displaySettings: $zaglushka)
                    .padding(.trailing, 10)
            }
            .padding(.top, 5)
            
            Spacer()
        }
    }
}
