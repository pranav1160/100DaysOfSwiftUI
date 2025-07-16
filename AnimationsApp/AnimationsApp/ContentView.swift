//
//  ContentView.swift
//  AnimationsApp
//
//  Created by Pranav on 15/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var animateBool = false
    var body: some View {
        VStack{
            Button{
                animateBool.toggle()
            }label: {
                Rectangle()
                    .frame(width: 200,height: 200)
                    .foregroundStyle(animateBool ? .blue : .red)
                    .clipShape(.rect(cornerRadius: animateBool ? 0 : 50))
                    .animation(.bouncy,value: animateBool)
                   
            }
            
        }
    }
}

#Preview {
    ContentView()
}
