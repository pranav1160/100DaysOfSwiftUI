//
//  ContentView.swift
//  MoonShots
//
//  Created by Pranav on 25/07/25.
//

import SwiftUI


let astronauts = Bundle.main.decode("astronauts.json")


struct ContentView: View {
    var body: some View {
        ScrollView {
            Text(String(astronauts.count))
        }
    }
}

#Preview {
    ContentView()
}


