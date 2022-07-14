//
//  BottomSheetView.swift
//  WeatherApp
//
//  Created by MSENSIS on 12/7/22.
//

import Foundation
import SwiftUI


struct BlurView: UIViewRepresentable{
    var style: UIBlurEffect.Style
    
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view  = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
