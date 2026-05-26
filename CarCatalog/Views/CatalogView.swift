//
//  CatalogView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import SwiftUI

struct CatalogView: View {
    @State var priceFilter = PriceFilter.off
    @State var selectedCategory: ToyotaCar.Category? = nil
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
                    Text(car.category.rawValue)
                }
                Spacer()
                Text(car.isAvailable ? "В наличии" : "Под заказ")
            }
            HStack {
                Text("\(car.year)")
                Spacer()
                Text("$\(car.price)")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.secondary.opacity(0.1))
        )
    }
}

struct CarList: View {
    @ObservedObject var carStore: CarStore

    var body: some View {

        List {
            Text("Cars sorted by price in order")
            ForEach(carStore.sortedCars) { car in
                CarInfo(car: car)
            }.onDelete { indexSet in
                let carsToDelete = indexSet.map { carStore.sortedCars[$0] }
                for car in carsToDelete {
                    carStore.deleteCar(withId: car.id)
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
                carStore.priceFilter = .off
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
