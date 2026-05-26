//
//  CatalogView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import SwiftUI

struct CatalogView: View {
    @State var carStore = CarStore()

    var body: some View {
        VStack(spacing: 0) {
            Header(carStore: carStore)
            CarList(carStore: carStore)

        }
    }
}

struct CarInfo: View {
    let car: ToyotaCar

    var body: some View {
        VStack {
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
        }
    }
}

struct CarList: View {
    @ObservedObject var carStore: CarStore

    var body: some View {
        List {
            Section {
                HStack {
                    if let filter = carStore.priceFilter {
                        Text("\(filter.rawValue) price order.")
                    }

                    if let category = carStore.selectedCategory {
                        Text("\(category.rawValue)s only")
                    } else {
                        Text("All cars")
                    }
                }
            }

            let categories = carStore.sortedCars.keys.sorted { $0.rawValue < $1.rawValue }

            if categories.isEmpty {
                Section {
                    Text("No cars found")
                        .foregroundColor(.secondary)
                        .italic()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } else {
                ForEach(categories, id: \.self) { category in
                    Section(header: Text(category.rawValue.capitalized)) {
                        let carsInCategory = carStore.sortedCars[category] ?? []

                        ForEach(carsInCategory) { car in
                            CarInfo(car: car)
                        }
                        .onDelete { indexSet in
                            carStore.delete(at: indexSet, in: category)
                        }
                    }
                }
            }
        }
    }
}

struct Header: View {
    let carStore: CarStore
    var body: some View {
        HStack {
            Text("AutoHouse")
                .font(Font.largeTitle.bold())

            Spacer()

            FilterByPriceButton(carStore: carStore)
            FilterByCategoryButton(carStore: carStore)
        }
        .padding()
        .background(
            Color.blue.opacity(0.1)
                           .ignoresSafeArea(edges: .top)
        )
    }
}

struct FilterByPriceButton: View {
    let carStore: CarStore
    var body: some View {
        Menu {
            Button("Ascending Price") {
                carStore.priceFilter = .ascending
            }

            Button("Descending Price") {
                carStore.priceFilter = .descending

            }

            Button("Withought filter") {
                carStore.priceFilter = nil
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down")
                .font(.title2)
                .padding()
                .foregroundStyle(Color.black)
                .background(
                    Circle().foregroundColor(.white)
                )
        }
    }
}

struct FilterByCategoryButton: View {
    let carStore: CarStore

    var body: some View {
        Menu {
            Button("Sedan's only") {
                carStore.selectedCategory = .sedan
            }
            Button("Sport's only") {
                carStore.selectedCategory = .sport
            }
            Button("SUV's only") {
                carStore.selectedCategory = .suv
            }
            Button("All categories") {
                carStore.selectedCategory = nil
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .font(.title)
                .padding()
                .foregroundStyle(Color.black)
                .background(
                    Circle().foregroundColor(.white)
                )
        }
    }
}

#Preview {
    ContentView()
}
