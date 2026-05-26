//
//  FavoritesView.swift
//  CarCatalog
//
//  Created by Maksim Shyshko on 20.05.2026.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var carStore: CarStore
    var body: some View {
        var favorites = carStore.favorites
        List {
            if favorites.isEmpty {
                Text("No favorite cars added")
            } else {
                ForEach(favorites) { car in
                    Text(car.model)
                }
            }
        }
    }
}

#Preview {
    FavoriteView(carStore: CarStore())
}
