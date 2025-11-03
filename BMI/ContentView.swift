//
//  ContentView.swift
//  BMI
//
//  Created by yonezawanatsuko on 2025/11/02.
//

import SwiftUI

struct ContentView: View {
    @State private var height: Double? = nil
    @State private var weight: Double? = nil
    
    @State private var selectUnit: String = "meter"
    
    let selctedUnits = ["meter","centimeter"]
    
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    HStack{
                        TextField("身長を入力",value: $height,format: .number)
                            .keyboardType(.decimalPad)
                        Picker("", selection: $selectUnit) {
                            ForEach(selctedUnits, id:\.self) { unit in
                                Text(unit)
                            }
                        }
                        .pickerStyle(.automatic)
                    }
                    .padding([.leading, .trailing], 8)
                    
                    HStack{
                        TextField("体重を入力",value: $weight,format: .number)
                            .keyboardType(.decimalPad)
                        Text("Kg")
                    }
                    .padding([.leading, .trailing], 8)
                }header: {
                    Text("入力")
                }
                
                Section{
                    if let height, let weight, height > 0 , weight > 0 {
                        let BMI = BMIcalculation(height:height,weight:weight,selectUnit: selectUnit)
                        Text(String(format:"%.2f",BMI))
                            .padding([.leading], 8)
                        Text(BMIassessment(bmi:BMI))
                            .padding([.leading], 8)
                    }else{
                        Text("身長と体重を入力してください")
                            .foregroundStyle(.gray)
                            .padding([.leading], 8)
                        Text("BMI評価")
                            .foregroundStyle(.gray)
                            .padding([.leading], 8)
                    }
                }
                header: {
                    Text("結果")
                }
                
            }
            .navigationTitle("BMI計算アプリ")
        }
    }
}


//単位別BMI計算式関数
func BMIcalculation(height: Double, weight: Double,selectUnit:String) -> Double {
    switch selectUnit {
    case "meter":
        return weight / (height * height)
    case "centimeter":
        return weight / ((height / 100) * (height / 100))
    default:
        return 0
    }
}

//BMI評価関数
func BMIassessment(bmi: Double) -> String {
    switch bmi {
    case 0.0..<18.5:
        return "低体重"
    case 18.5..<25.0:
        return "普通体重"
    case 25...:
        return "肥満"
    default:
        return ""
    }
}

#Preview {
    ContentView()
}
