//
//  Models.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import Foundation

struct Car: Identifiable {
    let id = UUID()
    let brand: String
    let model: String
    let year: Int
    let price: Int
    let category: Category
    let isAvailable: Bool

    init(brand: String, model: String, year: Int, price: Int, category: Category, isAvailable: Bool) {
        self.brand = brand
        self.model = model
        self.year = year
        self.price = price
        self.category = category
        self.isAvailable = isAvailable
    }

    enum Category: String, CaseIterable {
        case sedan = "Sedan"
        case suv = "SUV"
        case sport = "Sport"
        case hatchback = "Hatchback"

        var title: String {
            return self.rawValue
        }
    }
}

enum PriceFilter: String, CaseIterable {
    case ascending = "Ascending"
    case descending = "Descending"
}
