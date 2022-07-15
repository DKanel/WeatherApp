//
//  SplashView.swift
//  WeatherApp
//
//  Created by MSENSIS on 15/7/22.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            ContentView()
        }else{
            VStack{
                VStack{
                    Image(systemName: "thermometer.sun.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    Text("Weather App")
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear(){
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.2
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
       
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
