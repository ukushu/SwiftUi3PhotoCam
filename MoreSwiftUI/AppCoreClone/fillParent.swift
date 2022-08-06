//
//  fillParent.swift
//  Videq
//
//  Created by UKS on 07.08.2022.
//

import Foundation
import SwiftUI

public extension View {
    func takeAllAvailableSpace() -> some View
    {
         self
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity
                )
    }
    
    func fillParent() -> some View {
        self.takeAllAvailableSpace()
    }
}
