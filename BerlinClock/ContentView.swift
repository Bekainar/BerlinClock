//
//  ContentView.swift
//  BerlinClock
//
//  Created by Bekainar on 29.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var time = Date()
    @State private var mainTime = Date.now
    
    var body: some View {
        VStack{
            titleText
            berlinClock
            datePicker
                .environment(\.locale, Locale(identifier: "ru_RU"))
            Spacer()
        }
    }
    
//-----------------
// functions
    func blinkingLight() -> Color {
        let components = Calendar.current.dateComponents([.second], from: time)
        return components.second! % 2 == 0 ? .yellow : .yellow.opacity(0.7)
    }
    
    func fiveHourLight(index: Int) -> Color {
        let components = Calendar.current.dateComponents([.hour], from: time)
            let hours = components.hour!

            if index < hours / 5 {
                return .red
            } else {
            return .red.opacity(0.6)
            }
        }
    
    func hourLight(index: Int) -> Color {
        let components = Calendar.current.dateComponents([.hour], from: time)
            let hours = components.hour!

            if index < hours % 5 {
                return .red
            } else {
                return .red.opacity(0.7)
            }
        }
    
    func fiveMinuteLight(index: Int) -> Color {
            let components = Calendar.current.dateComponents([.minute], from: time)
            let minutes = components.minute!

            
            if index < minutes / 5 {
                if (index + 1) % 3 == 0{
                    return .red
                } else {
                    return .yellow
                }
            } else {
                return .gray
            }
            
        }
    
    func minuteLight(index: Int) -> Color {
            let components = Calendar.current.dateComponents([.minute], from: time)
            let minutes = components.minute!
        
        if index < minutes % 5 {
            return .red
        } else {
            return .red.opacity(0.7)
        }
    }
    
//------------------
// main body
    
    var titleText: some View{
        Text("Time is \(mainTime.formatted(date: .omitted, time: .shortened))")
            .font(.system(size: 17, weight: .bold))
    }
    
    
    var datePicker: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(width:358, height: 54)
                .padding(.horizontal, 16)
                .foregroundColor(.white)
                .shadow(radius: 6)
            HStack{
                DatePicker(selection: $time , displayedComponents: .hourAndMinute) {
                    Text("Insert time")
                        .font(.system(size: 18, weight: .medium))
                }
                .datePickerStyle(.compact)
            } .padding(32)
        }
    }
    
    //--------
    
    var berlinClock : some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 358, height: 312)
                .foregroundColor(.white)
                .shadow(radius: 6)
            VStack{
                Circle()
                    .frame(width:56, height: 56)
                    .foregroundColor(blinkingLight())
                
                HStack(spacing: 10){
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 74, height: 32)
                            .foregroundColor(fiveHourLight(index: index))
                    }
                }
                HStack(spacing: 10){
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 74, height: 32)
                            .foregroundColor(hourLight(index: index))
                    }
                }
                HStack(spacing: 10){
                    ForEach(0..<11) { index in
                        if (index + 1) % 3 == 0 {
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: 21, height: 32)
                                .foregroundColor(fiveMinuteLight(index: index))
                        }
                        else {
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: 21, height: 32)
                                .foregroundColor(fiveMinuteLight(index: index))
                        }
                    }
                }
                HStack(spacing: 10){
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 74, height: 32)
                            .foregroundColor(minuteLight(index: index))
                    }
                }
            }
        }
    }
}

    
        
    
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
