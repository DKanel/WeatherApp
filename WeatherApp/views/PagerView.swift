//
//  PagerView.swift
//  WeatherApp
//
//  Created by MSENSIS on 22/7/22.
//

import SwiftUI
import SwiftUIPager

struct PagerView: View {
    
    @State var data: [Double] = []
    @State var backgroundColor = Color.clear
    @StateObject var page: Page = .first()
    let pagerVM = PagerViewModel()
    var items = Array(0..<4)
    
    var body: some View {
        ZStack{
            VStack{
            Text("TOP")
            Pager(page: page, data: items, id: \.self, content: { index in
                if index != 0{
                    BarChartView(data: $data)
                }
            })
            .onPageChanged { index in
                if index != 0 {
                backgroundColor = Color.white
                }
                else if index == 0{
                    backgroundColor = Color.clear
                }
            }.ignoresSafeArea(.all)
            Text("BOTTOM")
            }
        }
        .background(backgroundColor)
//        .ignoresSafeArea(.all)
        .onAppear(){
//            if page.index != 0{
//                backgroundColor = Color.white
//            }
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
