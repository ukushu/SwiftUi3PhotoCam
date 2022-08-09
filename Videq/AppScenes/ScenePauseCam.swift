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
            
            if let _ = camera.previewURL, camera.showPreview {
                VideoPreview(model: camera)
                    .transition(.move (edge:.trailing))
                    
            } else {
                BackToMainMenuBtn(confirmationNeeded: camera.recordedURLs.count > 0 || camera.isRecording)
            }
            
            VideoConfigView()
                .environmentObject(camera)
        }
    }
}

struct VideoConfigView: View {
    @EnvironmentObject var camera: CameraModel
    
    @State var test = 0
    
    var body: some View {
        VStack {
            Space()
            VStack {
                HStack {
                    if camera.qualityPersets.count > 1 {
                        Text("\(camera.qualityPersets[test].asStr)")
                        
                        BoundsSliderInt(min: 0, max: (camera.qualityPersets.count-1), value: $test)
                    }
                }.frame(width: 200)
            }
            .background(.ultraThinMaterial)
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
