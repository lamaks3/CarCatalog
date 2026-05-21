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
            Header(priceFilter: $priceFilter, selectedCategory: $selectedCategory)
            if priceFilter == .off {
                CarsByCategory(carStore: carStore, selectedCategory: $selectedCategory)
            } else {
                AllCarList(
                    carStore: carStore,
                    priceFilter: $priceFilter,
                    selectedCategory: $selectedCategory
                )
            }

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

struct AllCarList: View {
    let carStore: CarStore
    @Binding var priceFilter: PriceFilter
    @Binding var selectedCategory: ToyotaCar.Category?

    private var filteredAndSortedCars: [ToyotaCar] {
        var carList: [ToyotaCar] = carStore.cars
        if let selectedCategory {
            carList = carList.filter { $0.category == selectedCategory }
        }

        if priceFilter == .ascending {
            carList.sort { $0.price < $1.price }
        } else if priceFilter == .descending {
            carList.sort { $0.price > $1.price }
        }

        return carList
    }

    var body: some View {

        List {
            Text("Cars sorted by price in \(priceFilter.rawValue) order")
            ForEach(filteredAndSortedCars) { car in
                CarInfo(car: car)
            }.onDelete { indexSet in
                let carsToDelete = indexSet.map { filteredAndSortedCars[$0] }
                for car in carsToDelete {
                    carStore.deleteCar(withId: car.id)
                }
            }
        }
    }
}

struct CarsByCategory: View {
    let carStore: CarStore
    @Binding var selectedCategory: ToyotaCar.Category?
    var body: some View {
        List {
            if !(carStore.cars.filter { $0.category == .sedan}).isEmpty && (selectedCategory == .sedan || selectedCategory == nil) {
                Section(header: Text("Sedan")) {
                    ForEach(carStore.cars.filter { $0.category == .sedan}) { car in
                        CarInfo(car: car)
                    }
                }
            }
            if !(carStore.cars.filter { $0.category == .sport}).isEmpty && (selectedCategory == .sport || selectedCategory == nil) {
                Section(header: Text("Sport")) {
                    ForEach(carStore.cars.filter { $0.category == .sport}) { car in
                        CarInfo(car: car)
                    }
                }
            }
            if !(carStore.cars.filter { $0.category == .suv}).isEmpty && (selectedCategory == .suv || selectedCategory == nil) {
                Section(header: Text("SUV")) {
                    ForEach(carStore.cars.filter { $0.category == .suv}) { car in
                        CarInfo(car: car)
                    }
                }
            }
        }
    }
}

struct Header: View {
    @Binding var priceFilter: PriceFilter
    @Binding var selectedCategory: ToyotaCar.Category?
    var body: some View {
        HStack {
            Text("AutoHouse")
                .font(Font.largeTitle.bold())

            Spacer()

            FilterByPriceButton(priceFilter: $priceFilter)
            FilterByCategoryButton(selectedCategory: $selectedCategory)
        }
        .padding()
        .background(
            Color.blue.opacity(0.1)
                           .ignoresSafeArea(edges: .top)
        )
    }
}

struct FilterByPriceButton: View {
    @Binding var priceFilter: PriceFilter
    var body: some View {
        Menu {
            Button("Ascending Price") {
                priceFilter = .ascending
            }

            Button("Descending Price") {
                priceFilter = .descending
            }

            Button("Withought filter") {
                priceFilter = .off
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
    @Binding var selectedCategory: ToyotaCar.Category?

    var body: some View {
        Menu {
            Button("Sedan's only") {
                selectedCategory = .sedan
            }
            Button("Sport's only") {
                selectedCategory = .sport
            }
            Button("SUV's only") {
                selectedCategory = .suv
            }
            Button("All categories") {
                selectedCategory = nil
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
