//
//  ContentView.swift
//  iExpense
//
//  Created by Pranav on 20/07/25.
//

import SwiftUI

struct User:Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    //numbers
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        VStack{
            Button("Save User"){
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(user){
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
        }
       
    }
    
}

#Preview {
    ContentView()
}


