//
//  BlurView.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import Foundation
import SwiftUI
struct BlurView: NSViewRepresentable {
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
    
    func makeNSView(context: Context) -> some NSVisualEffectView {
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        
        return view
    }
}
