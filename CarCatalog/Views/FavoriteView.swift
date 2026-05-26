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
        let favorites = carStore.favorites
        VStack(spacing: 0) {
            FavoritesHeader()
            List {
                if favorites.isEmpty {
                    Text("No favorite cars added")
                } else {
                    ForEach(favorites) { car in
                        CarInfo(car: car)
                    }
                }
            }
        }
    }
}

struct FavoritesHeader: View {
    var body: some View {
        HStack {
            Text("Favorite Cars")
                .font(Font.largeTitle.bold())

            Spacer()
        }
        .padding()
        .background(
            ZStack {
                Color.yellow.opacity(0.1)
                HStack {
                    Spacer()
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.1)
                }
            }

            .ignoresSafeArea(edges: .top)
        )
    }
}

#Preview {
    FavoriteView(carStore: CarStore())
}
