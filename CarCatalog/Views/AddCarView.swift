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
    @State private var year: Int?
    @State private var price: Int?
    @State private var category: ToyotaCar.Category = .sedan
    @State private var isAvailable = true
    @State private var showBadFormAlert = false

    var isFormValid: Bool {
        guard !carBrand.isEmpty, !model.isEmpty, let year = year, let price = price else { return false }
        if year < 1920 || price < 0 {
            return false
        }
        return true
    }

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
                    TextField("Price($)", value: $price, format: .number)
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
                        {
                    if isFormValid {
                        let car = ToyotaCar(model: model, year: year!, price: price!, category: category, isAvailable: isAvailable)
                        store.add(car: car)
                        dismiss()
                    } else {
                        showBadFormAlert = true
                    }
                })
                {
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
                }
                .alert("Incorrect form, please check all fields", isPresented: $showBadFormAlert) { Button("OK", role: .cancel) { } }
            }
        }
    }
}

#Preview {
    let store = CarStore()
    AddCarView(store: store)
}
