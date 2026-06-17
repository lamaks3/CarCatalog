//
//  CatDetailView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import SwiftUI

struct CarDetailView: View {
    @ObservedObject var viewModel: CatalogViewModel
    var car: Car

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue.opacity(0.3))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)

                    Image(systemName: "car.fill")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .opacity(0.5)
                }
            }

            HStack {
                VStack(alignment: .leading) {
                    Text("\(car.brand) \(car.model)")
                        .font(.headline)
                    Text(car.category.title)
                }
                Spacer()
                Text(car.isAvailable ? "In stock" : "Out of stock")
                    .foregroundStyle(car.isAvailable ? .green : .red)
                    .padding(7)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(car.isAvailable ? .green.opacity(0.1) : .red.opacity(0.1))
                    )
            }

            HStack {
                Text("\(car.year, format: .number.grouping(.never)) y.")
                Spacer()
                Text("$\(car.price)")
                    .bold()
            }
            HStack {
                FavoriteButton(viewModel: viewModel, car: car)
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct FavoriteButton: View {
    @ObservedObject var viewModel: CatalogViewModel
    let car: Car
    var isSelected: Bool {
            if let actualCar = viewModel.cars.first(where: { $0.id == car.id }) {
                return actualCar.isFavorite
            }
            return false
    }

    var body: some View {
        Button(action: {
            viewModel.toggleFavorite(car)
        }) {
            Image(systemName: isSelected ? "star.fill" : "star")
                .font(.title)
                .foregroundColor(Color.primary)
                .opacity(isSelected ? 1 : 0.5)
        }
    }
}

#Preview {
    let car = Car(
        brand: "Audi",
        model: "A5",
        year: 2005,
        price: 12000,
        category: Car.Category.sedan,
        isAvailable: false,
        isFavorite: false
    )
    CarDetailView(viewModel: CatalogViewModel(), car: car)
}
