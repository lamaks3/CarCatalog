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
    var isFavorite: Bool

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
