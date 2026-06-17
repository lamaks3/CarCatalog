//
//  ViewModel.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import Foundation
import Combine

@MainActor
class CarStore: ObservableObject {
    @Published var cars: [Car] = []

    @Published var priceFilter: PriceFilter? = nil
    @Published var selectedCategory: Car.Category? = nil

    private let repository: CarRepositoryProtocol

    init(repository: CarRepositoryProtocol) {
            self.repository = repository
            fetchCars()
        }

    convenience init() {
        self.init(repository: CoreDataCarRepository())
    }

    private func fetchCars() {
        self.cars = repository.fetchAllCars()
    }

    var sortedCars: [String : [Car]] {
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
            return ["All cars" : result]
        }
        return Dictionary(grouping: result, by: { $0.category.title })
    }

    var favoriteCars: [Car] {
        cars.filter { $0.isFavorite }
    }

    func toggleFavorite(_ car: Car) {
        if let index = cars.firstIndex(where: { $0.id == car.id }) {
            var updatedCar = cars[index]
            updatedCar.isFavorite.toggle()
            cars[index] = updatedCar

            repository.update(car: updatedCar)
        }
    }

    public func delete(car: Car) {
        repository.delete(car: car)
        fetchCars()
    }

    public func add(car: Car) {
        repository.save(car: car)
        fetchCars()
    }
}
