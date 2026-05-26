//
//  CatDetailView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import SwiftUI

struct CarDetailView: View {
    @ObservedObject var carStore: CarStore
    var car: ToyotaCar

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue.opacity(0.1))
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
                    Text("Toyota \(car.model)")
                        .font(.headline)
                    Text(car.category.rawValue)
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
                FavoriteButton(carStore: carStore, car: car)
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct FavoriteButton: View {
    @ObservedObject var carStore: CarStore
    let car: ToyotaCar
    var isSelected: Bool {
        carStore.favorites.contains(where: { $0.id == car.id })
    }

    var body: some View {
        Button(action: {
            carStore.toggleFavorite(car)
        }) {
            Image(systemName: isSelected ? "star.fill" : "star")
                .font(.title)
                .foregroundColor(isSelected ? .black : .gray)
        }
    }
}

#Preview {
    let car = ToyotaCar(
        model: "RAV 4",
        year: 2005,
        price: 12000,
        category: ToyotaCar.Category.suv,
        isAvailable: false
    )
    CarDetailView(carStore: CarStore(), car: car)
}
