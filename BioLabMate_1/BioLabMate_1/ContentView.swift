//
//  ContentView.swift
//  BioLabMate_1
//
//  Created by Neo on 7/18/24.
//

import SwiftUI

struct ContentView: View {
    //Standard curve(y=ax+b)
    //흡광도
    
    @State var a:String = ""
    @State var b:String = ""
    
    @State var y:String = ""
    
    @State var x:Double = 0
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                VStack (alignment: .leading){
                    Text("Standard curve (y=ax+b)")
                    Text("")
                    Text("a")
                    TextField("a값을 입력하세요", text:$a)
                    Text("")
                    Text("b")
                    TextField("b값을 입력하세요", text:$b)
                }.padding()
                
                VStack (alignment: .leading){
                    Text("")
                    Text("")
                    Text("흡광도(O.D.)")
                    Text("")
                    Text("y")
                    TextField("y값을 입력하세요", text:$y)
                }.padding()
                
                
                Button("↓"){
                    x = ((Double(y) ?? 0) - (Double(b) ?? 0)) / (Double(a) ?? 0)
                }.padding()
                
                Text("가진 sample을 \(x, specifier: "%.2f") μg/μl 넣어줘야 합니다.")
                    .padding(.top, 20)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: { /* O.D. action */ }) {
                        Text("O.D.")
                    }
                    Spacer()
                    Button(action: { /* Unit action */ }) {
                        Text("Unit")
                    }
                    Spacer()
                    Button(action: { /* Record action */ }) {
                        Text("Record")
                    }
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                
            }.navigationBarTitle("BioLabMate", displayMode: .inline)
        }
    }
}


    #Preview {
            ContentView()
        }

