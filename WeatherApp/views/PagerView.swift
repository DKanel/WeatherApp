//
//  PagerView.swift
//  WeatherApp
//
//  Created by MSENSIS on 22/7/22.
//

import SwiftUI
import SwiftUIPager
import SDWebImageSwiftUI


struct PagerView: View {
    
    @State var data: [Double] = []
    @State var backgroundColor = Color.clear
    @State var showBarChart = 1.0
    @State var isAnimating: Bool = true
    @State var gifImage = "https://media0.giphy.com/media/k3CeSrt9IZ6aorWCy1/giphy.gif?cid=790b761121d68267b7f23c0b7d9eb18adac72f147580195b&rid=giphy.gif&ct=g"
    @StateObject var page: Page = .first()

    let pagerVM = PagerViewModel()
    var items = Array(0..<4)
    
    var body: some View {
        ZStack{
            WebImage(url: URL(string: gifImage),isAnimating: $isAnimating)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
            VStack{
                TabView(){
                    BasicTempratureInfosView()
                    BarChartView(data: $data)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                .tabViewStyle(.page)
                .ignoresSafeArea(.all)
            }
        }
        .onAppear(){
            pagerVM.makeCall { response in
                for temp in response[0...23]{
                    data.append(temp.hTemperature)
                    print("HEEERE",data)
                }
                
            }
        }
    }
}

//struct PagerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PagerView()
//    }
//}
