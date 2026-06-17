//
//  ContentView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var viewModel = CatalogViewModel()
    var body: some View {
        NavigationStack {
            TabView {
                CatalogView(viewModel: viewModel)
                    .tabItem {
                        Label("Catalog", systemImage: "car")
                    }
                FavoriteView(viewModel: viewModel)
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
