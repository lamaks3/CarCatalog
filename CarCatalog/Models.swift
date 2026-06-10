//
//  Models.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import Foundation

struct Car: Identifiable, Equatable, Hashable {
    var id = UUID()
    let brand: String
    let model: String
    let year: Int
    let price: Int
    let category: Category
    let isAvailable: Bool

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

extension Car {
    init?(entity: CarEntity) {
        guard let id = entity.id,
              let brand = entity.brand,
              let model = entity.model,
              let categoryString = entity.category,
              let category = Category(rawValue: categoryString) else {
            return nil
        }

        self.id = id
        self.brand = brand
        self.model = model
        self.year = Int(entity.year)
        self.price = Int(entity.price)
        self.category = category
        self.isAvailable = entity.isAvailable
    }
}

enum PriceFilter: String, CaseIterable {
    case ascending = "Ascending"
    case descending = "Descending"
}
