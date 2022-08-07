//
//  TeleprompterSettingsView.swift
//  Videq
//
//  Created by UKS on 06.08.2022.
//

import Foundation
import SwiftUI

struct TeleprompterSettingsView: View {
    @ObservedObject var model: TeleprompterViewModel
    
    var body: some View {
            VStack {
                if model.displaySettings {
                    VStack {
                        VStack {
                            SpeedSlider()
                                .padding(.trailing, 50)
                            
                            HStack {
                                TextSizeSlider()
                                
                                ColorPicker(selection: $model.textColor) { EmptyView() }
                                    .frame(width: 25)
                                    .padding(.trailing, 5)
                                    .padding(.leading, 10)
                            }
                            
                            if model.miniMode {
                                BgOpacitySlider()
                                    .padding(.trailing, 50)
                            }
                            
                            MarginsSlider()
                            
                            if !model.miniMode {
                                Toggle("Mirror by Y axis", isOn: $model.mirrorYAxis)
                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 15)
                    .background(model.miniMode ? .ultraThickMaterial : .ultraThinMaterial)
                }
            }
            .animation(.easeInOut, value: model.displaySettings)
    }
}
