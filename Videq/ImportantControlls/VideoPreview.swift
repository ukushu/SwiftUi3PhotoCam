//
//  VideoPreview.swift
//  PCam
//
//  Created by UKS on 06.08.2022.
//

import Foundation
import AVKit
import SwiftUI

struct VideoPreview: View {
    @ObservedObject var model: CameraModel
    
    var body: some View {
        ZStack{
            if let url = model.previewURL, model.showPreview {
                GeometryReader{ proxy in
                    VideoPlayer(player: AVPlayer(url: url))
                        .aspectRatio (contentMode :.fit)
                        .frame (width : proxy.size.width, height : proxy.size.height)
                }
            } else {
                Text("Failed to display preview")
            }
            
            HeaderBgLine()
            
            BackBtn{ model.showPreview.toggle() }
            
            PreviewControlPanel()
        }
        .background(Color.black)
    }
}

extension VideoPreview {
    
    @ViewBuilder
    func PreviewControlPanel() -> some View {
        VStack {
            Spacer()
            
            ZStack {
                HStack() {
                    if model.recordedURLs.count > 1 {
                        NextPrevPanel()
                    }
                    
                    Space()
                }
                
                HStack() {
                    Button(action: { model.deleteCurr() } )
                        { SuperBtnLabel(text: "Delete", icon: "trash") }
                    
                    Button(action: { model.saveResult() } )
                        { SuperBtnLabel(text: "Save", icon: "square.and.arrow.down.fill") }
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)
            .background(.ultraThinMaterial)
        }
    }
    
    @ViewBuilder
    func NextPrevPanel() -> some View {
        let size: CGFloat = 30
        let color = Color.orange
        
        HStack(spacing: 10) {
            Button(action: { model.prevPreview() }) {
                Text("<").offset(x:0, y:-1).foregroundColor(.black)
            }
            .background {
                Circle().fill(color).frame(width: size, height: size)
            }
            .padding(10)
            
            Text("\(model.previewURLidx+1)/\(model.recordedURLs.count)")
            
            Button(action: { model.nextPreview() }) {
                Text(">").offset(x:0, y:-1).foregroundColor(.black)
            }
            .background {
                Circle().fill(color).frame(width: size, height: size)
            }
            .padding(10)
        }
    }
}


//////////////////
//HELPERS
//////////////////
fileprivate extension CameraModel {
    func nextPreview() {
        if recordedURLs.count == 0 {
            return
        }
        
        if previewURLidx + 1 >= recordedURLs.count {
            previewURLidx = 0
            return
        }
        
        previewURLidx += 1
    }
    
    func prevPreview() {
        if recordedURLs.count == 0 {
            return
        }
        
        if previewURLidx - 1 < 0 {
            previewURLidx = recordedURLs.count - 1
            return
        }
        
        previewURLidx -= 1
    }
    
    func deleteCurr() {
        let idxToDelete = previewURLidx
        
        if recordedURLs.count == 1 {
            previewURLidx = -1
            recordedURLs = []
            return
        }
        
        prevPreview()
        recordedURLs.remove(at: idxToDelete )
    }
}
