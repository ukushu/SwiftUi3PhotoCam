//
//  lockOrientation.swift
//  Videq
//
//  Created by UKS on 08.08.2022.
//

import Foundation
import SwiftUI

extension View {
    func lockOrientation() -> some View {
        self
//            .onAppear {
//                AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
//                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//                UINavigationController.attemptRotationToDeviceOrientation()
//            }
//            .onDisappear {
//                DispatchQueue.main.async {
//                    AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
//                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                    UINavigationController.attemptRotationToDeviceOrientation()
//                }
//            }
    }
}

// ADDITIONAL SOLUTION
//https://stackoverflow.com/a/41811798/4423545
