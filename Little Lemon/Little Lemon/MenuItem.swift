//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Evgeny Koshelev on 02.06.23.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let price: String
    let description: String
    let category: String
}
