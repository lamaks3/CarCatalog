//
//  Models.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import Foundation

struct ToyotaCar: Identifiable {
    let id = UUID()
    let model: String
    let year: Int
    let price: Int
    let category: Category
    let isAvailable: Bool

    enum Category: String, CaseIterable {
        case sedan = "Sedan"
        case suv = "SUV"
        case sport = "Sport"
    }
}

enum PriceFilter: String, CaseIterable {
    case off =  "off"
    case ascending = "ascending"
    case descending = "descending"
}
