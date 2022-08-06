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
    let isMini: Bool
    
    var body: some View {
            VStack {
                if model.displaySettings {
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
                                
                                ColorPicker(selection: $model.textColor) { EmptyView() }
                                    .frame(width: 25)
                                    .padding(.trailing, 5)
                                    .padding(.leading, 10)
                            }
                            
                            BgOpacitySlider()
                            
                            if !isMini {
                                Toggle("Mirror by Y axis", isOn: $model.mirrorYAxis)
                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 15)
                    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.7))
                } else {
                    VStack {
                        HStack {
                            Spacer()
                            BtnSettings()
                                .padding(10)
                                .id("BtnSettings")
                        }
                        
                        Spacer()
                    }
                }
            }
            .animation(.easeInOut, value: model.displaySettings)
    }
    
}
