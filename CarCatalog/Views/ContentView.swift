//
//  ContentView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let store = CarStore()
    var body: some View {
        CatalogView(cars: store.cars)
    }
}
