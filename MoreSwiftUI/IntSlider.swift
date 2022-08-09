//
//  IntSlider.swift
//  Videq
//
//  Created by UKS on 09.08.2022.
//

import Foundation
import SwiftUI

struct BoundsSliderInt: View {
    let min: Int
    let max: Int
    
    @Binding var value: Int
    
    
    var intProxy: Binding<Double>{
        Binding<Double>(get: {
            return Double(value)
        }, set: {
            value = Int($0)
        })
    }
    
    
    var body: some View {
        Slider(value: intProxy , in: (CGFloat(min))...(CGFloat(max)), step: 1.0)
    }
}
