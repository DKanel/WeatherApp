//
//  ContentView.swift
//  WeatherApp
//
//  Created by MSENSIS on 5/7/22.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import RxSwift

struct ContentView: View {
    
    var viewModel = WeatherViewModel()
    var disposeBag = DisposeBag()
    @ObservedObject var locationManager = LocationManager()
    @State var isActive = true
    @State var isAnimating: Bool = true
    @State private var showSheet = false
    @State var currentLocation = CLLocation(latitude: 52.5235, longitude: 13.4115)
    @State var imageName = ""
    @State var backgroundImage = "background"
    @State var gifImage = "https://media0.giphy.com/media/k3CeSrt9IZ6aorWCy1/giphy.gif?cid=790b761121d68267b7f23c0b7d9eb18adac72f147580195b&rid=giphy.gif&ct=g"
    @State var city = Cities.city.Athens
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
                WebImage(url: URL(string: gifImage),isAnimating: $isAnimating)
//                Image(backgroundImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height)
//                    .brightness(-0.1)
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
                    ForEach(1..<7) { number in
                        HStack{
                            Text(datesFormatted[number]).foregroundColor(textColor)
//                            Text("Max:").foregroundColor(textColor)
                            Text(temperaturesMinArray[number]).foregroundColor(textColor).bold()
//                            Text("Min:").foregroundColor(textColor)
                            Text("...").foregroundColor(textColor)
                            Text(temperaturesMaxArray[number]).foregroundColor(textColor).bold()
//                            Text("Weather:").foregroundColor(textColor)
                            if #available(iOS 15.0, *) {
                                Image(systemName: imagesNameArray[number])
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.size.width / 16, height:UIScreen.main.bounds.size.width / 16, alignment: .center)
                                    .foregroundStyle(colorForNextDayImages[number], colorForNextDayImages2[number])
                            } else {
                                // Fallback on earlier versions
                            }
                                }
                    }
                    Spacer()
                }
            }
            .blur(radius: viewModel.setBlur(offset: offset))
            PagerView()
            //BlurView
            GeometryReader{ proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                return AnyView(
                    ZStack{
                        BlurView(style: .systemThinMaterialDark)
                        VStack(spacing: 60){
                            Capsule()
                                .fill(.white)
                                .frame(width: 60, height: 4)
                                .padding(.top)
                            SheetView(currentCity: $currentCity,temperature: $temperature,temperaturesMaxArray: $temperaturesMaxArray,temperaturesMinArray: $temperaturesMinArray, imagesNameArray: $imagesNameArray,colorForNextDayImages: $colorForNextDayImages,colorForNextDayImages2: $colorForNextDayImages2,imageName: $imageName,imageColor: $imageColor,imageColor2: $imageColor2,offset: $offset, lastOffset: $lastOffset)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                        .offset(y: height - 60)
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
        .fullScreenCover(isPresented: $isActive, content: {
            SplashView(isActive: $isActive,loadedTemperature: $temperature)
        })
    
        
        .onAppear(){
            //Dates
            datesFormatted = viewModel.getDate()
            //Address
            locationManager.checkAuthorization()
            locationManager.getLocation { location in
                viewModel.getCity(location: location) { responseCity in
                    self.city = responseCity
                    currentCity = self.city.rawValue
                    
                    //Weather
                    viewModel.getWeather(urlIndex: city){ weatherResponse in
                        
                        //Set Background image
                        let isSunset = viewModel.checkForSunset()
                        if isSunset == true{
                            backgroundImage = "backgroundNight"
                            textColor = .white
                            gifImage = "https://bestanimations.com/media/moon/1531195013moon-animation49.gif"
                        }
                        viewModel.getCurrentTemperature(urlIndexForCurrentTemperature: city) { response in
                            
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
