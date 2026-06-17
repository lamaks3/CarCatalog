//
//  Car+Mapping.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 17.06.2026.
//

import Foundation

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
        self.isFavorite = entity.isFavorite
    }
}
