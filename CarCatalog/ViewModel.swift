//
//  ViewModel.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import Foundation
import Combine

class CarStore: ObservableObject {
    @Published var cars: [Car] = [
        Car(
            brand: "Toyota",
            model: "GR Yaris",
            year: 2025,
            price: 15000,
            category: Car.Category.sport,
            isAvailable: true
        ),
        Car(
            brand: "Toyota",
            model: "Yaris",
            year: 2025,
            price: 10000,
            category: Car.Category.sport,
            isAvailable: true
        ),
        Car(
            brand: "Toyota",
            model: "Celica",
            year: 2005,
            price: 12000,
            category: Car.Category.suv,
            isAvailable: false
        )
    ]
    @Published var favorites: [Car] = []
    @Published var priceFilter: PriceFilter? = nil
    @Published var selectedCategory: Car.Category? = nil

    var sortedCars: [Car.Category : [Car]] {
        var result = cars

        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }
        switch priceFilter {
        case .ascending:
            result.sort { $0.price < $1.price }
        case .descending:
            result.sort { $0.price > $1.price }
        default:
            break
        }
        if self.selectedCategory == nil && self.priceFilter != nil {
            return [Car.Category.all: result]
        }
        return Dictionary(grouping: result, by: { $0.category })
    }


    func toggleFavorite(_ car: Car) {
        if let index = favorites.firstIndex(where: { $0.id == car.id} ) {
            favorites.remove(at: index)
        } else {
            favorites.append(car)
        }
    }

    public func delete(at offsets: IndexSet, in category: Car.Category) {
        let filteredCars = cars.filter { $0.category == category }
        let carsToDelete = offsets.map { filteredCars[$0] }

        for car in carsToDelete {
            if let index = cars.firstIndex(where: { $0.id == car.id }) {
                cars.remove(at: index)
                favorites.removeAll { $0.id == car.id }
            }
        }
    }

    public func add(car: Car) {
        cars.append(car)
    }
}
