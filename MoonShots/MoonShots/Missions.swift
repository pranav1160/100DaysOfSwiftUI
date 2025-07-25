//
//  CrewRole.swift
//  MoonShots
//
//  Created by Pranav on 25/07/25.
//

import Foundation

struct CrewRole: Codable {
    let name: String
    let role: String
}


struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
