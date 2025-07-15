//
//  ContentView.swift
//  AnimationsApp
//
//  Created by Pranav on 15/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var animateVal = 1.0
    var body: some View {
        VStack{
            Button{
                withAnimation (.spring(duration: 1,bounce: 0.5)){
                    animateVal+=360
                }
                
            }label: {
                Circle()
                    .frame(width: 200,height: 200)
                    .foregroundStyle(.red)
                    .rotation3DEffect(.degrees(animateVal), axis: (x: 0, y: 1, z: 0))
            }
            
        }
    }
}

#Preview {
    ContentView()
}
