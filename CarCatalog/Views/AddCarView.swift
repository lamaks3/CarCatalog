//
//  AddCarView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 03.06.2026.
//

import SwiftUI

struct AddCarView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: CarStore
    @State private var carBrand: String = ""
    @State private var model: String = ""
    @State private var year: Int = 0
    @State private var price: Int = 0
    @State private var category = ToyotaCar.Category.sedan
    @State private var isAvailable: Bool = true

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Add Car")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Spacer()
                }
                Form {
                    TextField(text: $carBrand){
                        Text("Car Brand")
                    }
                    TextField(text: $model){
                        Text("Model")
                    }
                    TextField("Year", value: $year, format: .number)
                        .keyboardType(.numberPad)
                    TextField("Price", value: $price, format: .number)
                        .keyboardType(.numberPad)
                    Picker("Category", selection: $category) {
                        Text("Sedan").tag(ToyotaCar.Category.sedan)
                        Text("SUV").tag(ToyotaCar.Category.suv)
                        Text("Sport").tag(ToyotaCar.Category.sport)
                    }
                    Picker("Avaibiality", selection: $isAvailable) {
                        Text("In Stock").tag(true)
                        Text("Out of Stock").tag(false)
                    }
                }

            }
            VStack {
                Spacer()
                Button(action:
                        {let car = ToyotaCar(model: model, year: year, price: price, category: category, isAvailable: isAvailable)
                    store.add(car: car)
                    dismiss()
                }) {
                    HStack {
                        Text("Add car")
                            .foregroundStyle(Color.white)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(Color.primary)

                    )
                    .padding()
                }}

        }
    }
}

#Preview {
    let store = CarStore()
    AddCarView(store: store)
}
