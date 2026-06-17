//
//  CatalogView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import SwiftUI

struct CatalogView: View {
    @StateObject var viewModel = CatalogViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Header(viewModel: viewModel)
                CarList(viewModel: viewModel)
            }
            AddCarButton(viewModel: viewModel)
        }
    }
}

struct CarInfo: View {
    let car: Car

    var body: some View {
        VStack {
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
        }
    }
}

struct CarList: View {
    @ObservedObject var viewModel: CatalogViewModel

    var body: some View {
        List {
            Section {
                HStack {
                    if let filter = viewModel.priceFilter {
                        Text("\(filter.rawValue) price order.")
                    }

                    if let category = viewModel.selectedCategory {
                        Text("\(category.title)s only")
                    } else {
                        Text("All cars")
                    }
                }
            }

            let categories = viewModel.sortedCars.keys

            if categories.isEmpty {
                Section {
                    Text("No cars found")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } else {
                ForEach(categories.sorted(), id: \.self) { category in
                    Section(header: Text(category)) {
                        let carsInCategory = viewModel.sortedCars[category] ?? []

                        ForEach(carsInCategory) { car in
                            NavigationLink {
                                   CarDetailView(viewModel: viewModel, car: car)
                               } label: {
                                   CarInfo(car: car)
                               }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let carToDelete = carsInCategory[index]
                                viewModel.delete(car: carToDelete)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct Header: View {
    @ObservedObject var viewModel: CatalogViewModel
    var body: some View {
        HStack {
            Text("AutoHouse")
                .font(Font.largeTitle.bold())

            Spacer()

            FilterByPriceButton(viewModel: viewModel)
            FilterByCategoryButton(viewModel: viewModel)
        }
        .padding()
        .background(
            Color.blue.opacity(0.2)
               .ignoresSafeArea(edges: .top)
        )
    }
}

struct FilterByPriceButton: View {
    let viewModel: CatalogViewModel
    var body: some View {
        Menu {
            Button("Ascending Price") {
                viewModel.priceFilter = .ascending
            }

            Button("Descending Price") {
                viewModel.priceFilter = .descending

            }

            Button("Withought filter") {
                viewModel.priceFilter = nil
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
    @ObservedObject var viewModel: CatalogViewModel

    var body: some View {
        Menu {
            ForEach(Car.Category.allCases, id: \.self) { category in
                Button("\(category.title)'s only") {
                    viewModel.selectedCategory = category
                }
            }
            Button("All cars") {
                viewModel.selectedCategory = nil
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

struct AddCarButton: View {
    @ObservedObject var viewModel: CatalogViewModel
    var body: some View {
        VStack() {
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    AddCarView(viewModel: viewModel)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color(UIColor.systemBackground))
                        .font(.title)
                        .bold()
                        .padding()
                        .background(
                            Circle().foregroundColor(.primary)
                        )
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
