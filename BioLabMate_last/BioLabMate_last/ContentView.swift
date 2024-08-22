//
//  ContentView.swift
//  BioLabMate_last
//
//  Created by Neo on 7/18/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplashScreen = true // 스플래시 화면 표시 여부
    @State private var selectedTab: String = "O.D." // 현재 선택된 탭
    @State private var records: [String] = [] // 계산 기록을 저장할 배열
    
    @State var a: String = ""
    @State var b: String = ""
    @State var c: String = ""
    
    @State var y: String = ""
    
    @State var x: Double = 0
    @State var d: Double = 0
    
    var body: some View {
        ZStack {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                NavigationStack {
                    VStack {
                        Spacer()
                        if selectedTab == "O.D." {
                            VStack(alignment: .leading) {
                                Text("Standard curve (y=ax+b)")
                                Text("")
                                Text("a")
                                TextField("a값을 입력하세요", text: $a)
                                Text("")
                                Text("b")
                                TextField("b값을 입력하세요", text: $b)
                            }.padding()
                            
                            VStack(alignment: .leading) {
                                Text("")
                                Text("")
                                Text("흡광도(O.D.)")
                                Text("")
                                Text("y")
                                TextField("y값을 입력하세요", text: $y)
                            }.padding()
                            
                            Button(action: {
                                x = ((Double(y) ?? 0) - (Double(b) ?? 0)) / (Double(a) ?? 0)
                                let record = String(format: "O.D.: %.2f μg/μl", x)
                                records.append(record)
                            }) {
                                Text("↓")
                            }.padding()
                            
                            Text(String(format: "가진 sample을 %.2f μg/μl 넣어줘야 합니다.", x))
                                .padding(.top, 20)
                        }
                        else if selectedTab == "Unit" {
                            UnitView(records: $records)
                        }
                        else if selectedTab == "Record" {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    ForEach(records.reversed(), id: \.self) { record in
                                        Text(record)
                                            .padding()
                                            .background(Color.white)
                                            .overlay(
                                                Rectangle()
                                                    .stroke(Color.gray, lineWidth: 1)
                                            )
                                            .padding(.bottom, 10)
                                    }
                                }.padding()
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                selectedTab = "O.D."
                            }) {
                                Text("O.D.")
                            }
                            Spacer()
                            Button(action: {
                                selectedTab = "Unit"
                            }) {
                                Text("Unit")
                            }
                            Spacer()
                            Button(action: {
                                selectedTab = "Record"
                            }) {
                                Text("Record")
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                    }
                        .toolbar {
                        ToolbarItem(placement: .principal) {
                            Image("BioLab") // 프로젝트에 추가한 이미지를 사용
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20) // 이미지 크기 조정
                            //.navigationBarTitle("BioLabMate", displayMode: .inline)
                        }
                    }
                }
            }
        }
    }
}
struct SplashScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("BioLabMate")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct UnitView: View {
    @State private var inputAmount: String = ""
    @State private var inputUnit: String = "mL"
    @State private var outputUnit: String = "L"
    @State private var result: Double = 0.0
    @Binding var records: [String]
    
    let units = ["mL", "L", "μL"]
    
    var body: some View {
        VStack {
            HStack {
                TextField("입력", text: $inputAmount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                Picker("단위", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            Button(action: {
                result = convert(amount: Double(inputAmount) ?? 0, from: inputUnit, to: outputUnit)
                let record = String(format: "Unit: %.2f %@ -> %.2f %@", Double(inputAmount) ?? 0, inputUnit, result, outputUnit)
                records.append(record)
            }){
                Text("↓")
            }
            .padding()
                   
            
            HStack {
                Text(String(format: "%.2f", result))
                Picker("단위", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
        }
        .padding()
    }
    
    func convert(amount: Double, from: String, to: String) -> Double {
        var baseAmountInML: Double = 0
        
        // Convert input to mL
        if from == "mL" {
            baseAmountInML = amount
        } else if from == "L" {
            baseAmountInML = amount * 1000
        } else if from == "μL" {
            baseAmountInML = amount / 1000
        }
        
        // Convert from mL to target unit
        if to == "mL" {
            return baseAmountInML
        } else if to == "L" {
            return baseAmountInML / 1000
        } else if to == "μL" {
            return baseAmountInML * 1000
        }
        
        return 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

