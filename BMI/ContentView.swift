//
//  ContentView.swift
//  BMI
//
//  Created by yonezawanatsuko on 2025/11/02.
//

import SwiftUI

struct ContentView: View {
    @State private var height: Double = 0
    @State private var weight: Double = 0
    
    @State private var selectUnit: String = "meter"
    
    let selctedUnits = ["meter","centimeter"]
    
    
    var body: some View {
        Form{
            Section{
                HStack{
                    TextField("身長を入力してください",value: $height,format: .number)
                    Picker("", selection: $selectUnit) {
                        ForEach(selctedUnits, id:\.self) { unit in
                            Text(unit)
                        }
                    }
                }
                .padding()
                HStack{
                    TextField("体重を入力してください",value: $weight,format: .number)
                    Text("Kg")
                }.padding()
            }header: {
                Text("入力")
            }
        
            Section{
                Text(BMI(height:height,weight:weight,selectUnit: selectUnit),format: .number)
                    .padding()
            }header: {
                Text("結果")
            }
        }
    }
}



func BMI(height: Double, weight: Double,selectUnit:String) -> Double {
    switch selectUnit {
    case "meter":
        return weight / (height * height)
    case "centimeter":
        return weight / ((height / 100) * (height / 100))
    default:
        return weight / (height * height)
    }
}

#Preview {
    ContentView()
}
