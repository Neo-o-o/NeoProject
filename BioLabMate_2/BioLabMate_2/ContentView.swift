//
//  ContentView.swift
//  BioLabMate_2
//
//  Created by Neo on 7/18/24.
//

import SwiftUI

struct ContentView: View {
    // Standard curve(y=ax+b)
    // 흡광도
    
    @State var a: String = ""
    @State var b: String = ""
    @State var c: String = ""
    
    @State var y: String = ""
    
    @State var x: Double = 0
    @State var d: Double = 0
    @State private var selectedTab: String = "O.D." // 현재 선택된 탭
    @State private var records: [String] = [] // 계산 기록을 저장할 배열
    
    var body: some View {
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
                    VStack {
                        HStack {
                            TextField("입력", text: $c)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 100)
                            Text("ml")
                        }
                        Button(action: {
                            d = (Double(c) ?? 0) * 1000
                            let record = String(format: "Unit: %.2f ml -> %.2f μl", Double(c) ?? 0, d)
                            records.append(record)
                        }) {
                            Text("↓")
                        }.padding()
                        
                        Text(String(format: "%.2f μl", d))
                            .padding(.top, 20)
                        
                    }.padding()
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
            .navigationBarTitle("BioLabMate", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
