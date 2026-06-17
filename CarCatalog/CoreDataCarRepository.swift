//
//  CoreDataCarRepository.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 10.06.2026.
//

import Foundation
import CoreData

protocol CarRepositoryProtocol {
    func fetchAllCars() -> [Car]
    func save(car: Car)
    func delete(car: Car)
    func update(car: Car)
}

// MARK: - Repository Implementation
class CoreDataCarRepository: CarRepositoryProtocol {

    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }

    func fetchAllCars() -> [Car] {
        let request: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "brand", ascending: true)]

        do {
            let entities = try context.fetch(request)
            return entities.compactMap { Car(entity: $0) }
        } catch {
            print("Donwload error: \(error)")
            return []
        }
    }

    func save(car: Car) {
        let newEntity = CarEntity(context: context)
        newEntity.update(from: car)
        CoreDataManager.shared.saveContext()
    }

    func delete(car: Car) {
        let request: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", car.id as CVarArg)

        if let entityToDelete = try? context.fetch(request).first {
            context.delete(entityToDelete)
            CoreDataManager.shared.saveContext()
        }
    }

    func update(car: Car) {
        let request: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", car.id as CVarArg)

        if let existingEntity = try? context.fetch(request).first {
            existingEntity.update(from: car)
            CoreDataManager.shared.saveContext()
        }
    }
}

// MARK: - CarEntity Extension

extension CarEntity {
    func update(from car: Car) {
        self.id = car.id
        self.brand = car.brand
        self.model = car.model

        self.year = Int64(car.year)
        self.price = Int64(car.price)

        self.category = car.category.rawValue
        self.isAvailable = car.isAvailable
        self.isFavorite = car.isFavorite
    }
}
