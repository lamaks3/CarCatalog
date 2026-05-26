//
//  ViewModel.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import Foundation
import Combine

class CarStore: ObservableObject {
    @Published var cars: [ToyotaCar] = [
        ToyotaCar(
            model: "GR Yaris",
            year: 2025,
            price: 15000,
            category: ToyotaCar.Category.sport,
            isAvailable: true
        ),
        ToyotaCar(
            model: "Yaris",
            year: 2025,
            price: 10000,
            category: ToyotaCar.Category.sport,
            isAvailable: true
        ),
        ToyotaCar(
            model: "Celica",
            year: 2005,
            price: 12000,
            category: ToyotaCar.Category.suv,
            isAvailable: false
        )
    ]
    @Published var favorites: [ToyotaCar] = []
    @Published var sortedCars: [ToyotaCar] = []

    func toggleFavorite(_ car: ToyotaCar) {
        if let index = favorites.firstIndex(where: { $0.id == car.id} ) {
            favorites.remove(at: index)
        } else {
            favorites.append(car)
        }
    }

    func deleteCar(withId id: UUID) {
            cars.removeAll { $0.id == id }
    }

    public func delete(at offsets: IndexSet, in category: ToyotaCar.Category) {
        let filteredCars = cars.filter { $0.category == category }
        let carsToDelete = offsets.map { filteredCars[$0] }

        for car in carsToDelete {
            if let index = cars.firstIndex(where: { $0.id == car.id }) {
                cars.remove(at: index)
            }
        }
    }

    public func getCars(category: ToyotaCar.Category?,filter: PriceFilter ) {
        var cars = self.cars

        if category != nil {
            cars = cars.filter { $0.category == category }
        }

        if filter == .ascending {
            cars = cars.sorted { $0.price < $1.price }
        } else if filter == .descending {
            cars = cars.sorted { $0.price > $1.price }
        }

        self.sortedCars = cars
    }
}
