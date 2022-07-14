//
//  ContentView.swift
//  WeatherApp
//
//  Created by MSENSIS on 5/7/22.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI

struct ContentView: View {
    
    var viewModel = WeatherViewModel()
    @ObservedObject var locationManager = LocationManager()
    @State var isAnimating: Bool = true
    @State private var showSheet = false
    @State var currentLocation = CLLocation(latitude: 52.5235, longitude: 13.4115)
    @State var imageName = ""
    @State var backgroundImage = "background"
    @State var imageColor: Color? = .white
    @State var imageColor2: Color? = .white
    @State var imageColorForecast: Color? = .white
    @State var imageColorForcast2: Color? = .white
    @State var textColor: Color? = .black
    @State var willRain = true
    @State var currentCity = ""
    @State var temperature = ""
    @State var imagesNameArray: [String] = ["","","","","","",""]
    @State var temperaturesMaxArray: [String] = ["","","","","","",""]
    @State var temperaturesMinArray: [String] = ["","","","","","",""]
    @State var datesFormatted: [String] = ["","","","","","",""]
    @State var colorForNextDayImages: [Color] = [.yellow,.yellow,.yellow,.yellow,.yellow,.yellow,.yellow]
    @State var colorForNextDayImages2: [Color] = [.yellow,.yellow,.yellow,.yellow,.yellow,.yellow,.yellow]
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack{
            //Background Image
            GeometryReader{ proxy in
                let frame  = proxy.frame(in: .global)
                //Gif
//                WebImage(url: URL(string: "https://media0.giphy.com/media/k3CeSrt9IZ6aorWCy1/giphy.gif?cid=790b761121d68267b7f23c0b7d9eb18adac72f147580195b&rid=giphy.gif&ct=g"),isAnimating: $isAnimating)
                Image(backgroundImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height)
                    .brightness(-0.1)
            }
            .ignoresSafeArea(.all)
            
            VStack(alignment: .center,spacing: 50){
                Text(currentCity).foregroundColor(textColor).bold()
                HStack{
                Text(temperature)
                        .foregroundColor(textColor)
                        .font(.system(size: 100))
                    Text("°C").foregroundColor(textColor)
                        .font(.system(size: 90))
                }
                VStack(alignment: .center){
                    Text("Temperatures in the next days:").foregroundColor(textColor)
                    HStack{
                        Text(datesFormatted[1]).foregroundColor(textColor)
                        Text("Max:").foregroundColor(textColor)
                        Text(temperaturesMaxArray[1]).foregroundColor(textColor).bold()
                        Text("Min:").foregroundColor(textColor)
                        Text(temperaturesMinArray[1]).foregroundColor(textColor).bold()
                        Text("Weather:").foregroundColor(textColor)
                        Image(systemName: imagesNameArray[1])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width / 16, height:UIScreen.main.bounds.size.width / 16, alignment: .center)
//                            .foregroundStyle(colorForNextDayImages[1], colorForNextDayImages2[1])
                            }
                    HStack{
                        Text(datesFormatted[2]).foregroundColor(textColor)
                        Text("Max:").foregroundColor(textColor)
                        Text(temperaturesMaxArray[2]).foregroundColor(textColor).bold()
                        Text("Min:").foregroundColor(textColor)
                        Text(temperaturesMinArray[2]).foregroundColor(textColor).bold()
                        Text("Weather:").foregroundColor(textColor)
                        Image(systemName: imagesNameArray[2])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width / 16, height:             UIScreen.main.bounds.size.width / 16, alignment: .center)
//                            .foregroundStyle(colorForNextDayImages[2], colorForNextDayImages2[2])
                    }
                    HStack{
                        Text(datesFormatted[3]).foregroundColor(textColor)
                        Text("Max:").foregroundColor(textColor)
                        Text(temperaturesMaxArray[3]).foregroundColor(textColor).bold()
                        Text("Min:").foregroundColor(textColor)
                        Text(temperaturesMinArray[3]).foregroundColor(textColor).bold()
                        Text("Weather:").foregroundColor(textColor)
                        Image(systemName: imagesNameArray[3])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width / 16, height:             UIScreen.main.bounds.size.width / 16, alignment: .center)
//                            .foregroundStyle(colorForNextDayImages[3], colorForNextDayImages2[3])
                    }
                    HStack{
                        Text(datesFormatted[4]).foregroundColor(textColor)
                        Text("Max:").foregroundColor(textColor)
                        Text(temperaturesMaxArray[4]).foregroundColor(textColor).bold()
                        Text("Min:").foregroundColor(textColor)
                        Text(temperaturesMinArray[4]).foregroundColor(textColor).bold()
                        Text("Weather:").foregroundColor(textColor)
                        Image(systemName: imagesNameArray[4])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width / 16, height:             UIScreen.main.bounds.size.width / 16, alignment: .center)
//                            .foregroundStyle(colorForNextDayImages[4], colorForNextDayImages2[4])
                    }
                    HStack{
                        Text(datesFormatted[5]).foregroundColor(textColor)
                        Text("Max:").foregroundColor(textColor)
                        Text(temperaturesMaxArray[5]).foregroundColor(textColor).bold()
                        Text("Min:").foregroundColor(textColor)
                        Text(temperaturesMinArray[5]).foregroundColor(textColor).bold()
                        Text("Weather:").foregroundColor(textColor)
                        Image(systemName: imagesNameArray[5])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width / 16, height:             UIScreen.main.bounds.size.width / 16, alignment: .center)
//                            .foregroundStyle(colorForNextDayImages[5], colorForNextDayImages2[5])
                    }
                    HStack{
                        Text(datesFormatted[6]).foregroundColor(textColor)
                        Text("Max:").foregroundColor(textColor)
                        Text(temperaturesMaxArray[6]).foregroundColor(textColor).bold()
                        Text("Min:").foregroundColor(textColor)
                        Text(temperaturesMinArray[6]).foregroundColor(textColor).bold()
                        Text("Weather:").foregroundColor(textColor)
                        Image(systemName: imagesNameArray[6])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width / 16, height:             UIScreen.main.bounds.size.width / 16, alignment: .center)
//                            .foregroundStyle(colorForNextDayImages[6], colorForNextDayImages2[6])
                    }
                }
                Spacer()
//                    .frame(width: UIScreen.main.bounds.width, height: 400, alignment: .center)
            }
            .blur(radius: viewModel.setBlur(offset: offset))
            
            //BlurView
            GeometryReader{ proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                return AnyView(
                    ZStack{
                        BlurView(style: .systemThinMaterialDark)
                        VStack{
                            Capsule()
                                .fill(.white)
                                .frame(width: 60, height: 4)
                                .padding(.top)
                            SheetView(currentCity: $currentCity,temperature: $temperature,temperaturesMaxArray: $temperaturesMaxArray,temperaturesMinArray: $temperaturesMinArray, imagesNameArray: $imagesNameArray,colorForNextDayImages: $colorForNextDayImages,colorForNextDayImages2: $colorForNextDayImages2,imageName: $imageName,imageColor: $imageColor,imageColor2: $imageColor2,offset: $offset, lastOffset: $lastOffset)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                        .offset(y: height - 30)
                        .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                        .gesture(DragGesture().updating($gestureOffset, body: {value, out, inP in
                            out = value.translation.height
                            DispatchQueue.main.async {
                                self.offset = gestureOffset + lastOffset
                            }
                        }).onEnded({ value in
                            let maxHeight = height - 100
                            withAnimation {
                                if -offset > 100 && -offset < maxHeight / 2 {
                                    offset = -(maxHeight / 3)
                                }
                                else if -offset > maxHeight / 2{
                                    offset = -maxHeight
                                }
                                else{
                                    offset = 0
                                }
                            }
                            lastOffset = offset
                        }))
                )
            }
            .ignoresSafeArea(.all,edges: .bottom)
        }
            .onAppear(){
                //Dates
                datesFormatted = viewModel.getDate()
                //Weather
                viewModel.getWeather(urlIndex: Cities.city.Athens){ weatherResponse in
                    //Set Background image
                    let isSunset = viewModel.checkForSunset()
                    if isSunset == true{
                        backgroundImage = "backgroundNight"
                        textColor = .white
                    }
                    //Address
//                    currentCity = locationManager.locationCity
                    
                    viewModel.getCurrentTemperature(urlIndexForCurrentTemperature: Cities.city.Athens) { response in
                        self.temperature = String(response.currentWeather)
                    }
                
                    let rainny = viewModel.getWeatherType()
                    if rainny == true{
                        imageName = "cloud.rain.fill"
                        imageColor = .gray
                        imageColor2 = .blue
                    }else{
                        imageName = "sun.max.fill"
                        imageColor = .yellow
                        imageColor2 = .yellow
                    }
                
                    let temperaturesMax = viewModel.getNextDaysMaxTemperature()
                    var numberIndexForTemperaturesMax = 0
                    for temperature in temperaturesMax {
                        temperaturesMaxArray[numberIndexForTemperaturesMax] = String(temperature.temperature)
                        numberIndexForTemperaturesMax = numberIndexForTemperaturesMax + 1
                    }
                    
                    let temperaturesMin = viewModel.getNextDaysMinTemperature()
                    var numberIndexForTemperaturesMin = 0
                    for temperature in temperaturesMin {
                        temperaturesMinArray[numberIndexForTemperaturesMin] = String(temperature.temperature)
                        numberIndexForTemperaturesMin = numberIndexForTemperaturesMin + 1
                    }

                    let rainInNextDays = viewModel.getNextDaysWeatherType()
                    var numberIndexForRains = 0
                    for rain in rainInNextDays{
                        if rain.rains > 0{
                            imagesNameArray[numberIndexForRains] = "cloud.rain.fill"
                            colorForNextDayImages[numberIndexForRains] = Color.gray
                            colorForNextDayImages2[numberIndexForRains] = Color.blue
                            numberIndexForRains = numberIndexForRains + 1
                        }else{
                            imagesNameArray[numberIndexForRains] = "sun.max.fill"
                            colorForNextDayImages[numberIndexForRains] = Color.yellow
                            colorForNextDayImages2[numberIndexForRains] = Color.yellow
                            numberIndexForRains = numberIndexForRains + 1
                        }
                    }
                }
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        } else {
            // Fallback on earlier versions
        }
    }
}
