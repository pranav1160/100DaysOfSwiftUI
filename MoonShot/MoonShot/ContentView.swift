//
//  ContentView.swift
//  MoonShot
//
//  Created by Pranav on 25/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(.aldrin)
                .frame(width: 300, height: 300)
                clipped()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
