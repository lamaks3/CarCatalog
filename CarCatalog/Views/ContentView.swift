//
//  ContentView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var carStore = CatalogViewModel()
    var body: some View {
        NavigationStack {
            TabView {
                CatalogView(carStore: carStore)
                    .tabItem {
                        Label("Catalog", systemImage: "car")
                    }
                FavoriteView(carStore: carStore)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
