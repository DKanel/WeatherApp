//
//  BarChartView.swift
//  WeatherApp
//
//  Created by MSENSIS on 22/7/22.
//

import SwiftUI

struct BarChartView: View {
    @Binding var data: [Double]
    
    
    var highestData: Double{
        let max = data.max() ?? 0.0
        if max == 0 {return 1.0}
        return max
    }
    
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                HStack(alignment: .bottom, spacing: 4.0) {
                    ForEach(data.indices, id: \.self) { index in
                        let width = (geometry.size.width / CGFloat(data.count)) - 4
                        let height = geometry.size.height * data[index] / highestData
                        
                        BarView(datum: data[index])
                            .frame(width: width, height: height, alignment: .bottom)
                    }
                }
            }
        }
    }
}


