# CarCatalog

**CarCatalog** is a native iOS application built with **SwiftUI** and **Core Data**. It allows users to browse, manage, and filter a catalog of cars, as well as keep track of their favorite vehicles. 

## ✨ Features

- **Browse Catalog**: View a list of cars grouped by their categories (Sedan, SUV, Sport, Hatchback).
- **Favorites Management**: Mark cars as favorites and access them quickly in a dedicated "Favorites" tab.
- **Sorting & Filtering**: 
  - Sort cars by price (Ascending / Descending).
  - Filter cars by specific categories.
- **Add New Cars**: A built-in form to add new cars with data validation (e.g., checks for valid year and price).
- **Details View**: View detailed information about a specific car, including availability status.
- **Swipe Actions**: Easily delete cars from the catalog or remove them from favorites using native swipe gestures.
- **Local Persistence**: All data is securely saved on the device using **Core Data**.

## 🛠 Tech Stack & Architecture

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Reactive Programming:** Combine (`@Published`, `ObservableObject`)
- **Database:** Core Data
- **Architecture:** **MVVM** (Model-View-ViewModel)
- **Design Pattern:** **Repository Pattern** (`CarRepositoryProtocol`) for abstracting data access and keeping the ViewModel clean.

## 📱 Screenshots

> | Catalog | Price Filter | Category Filter | Add Car | Favorites |
> | :---: | :---: | :---: | :---: | :---: |
> | <img src="https://github.com/lamaks3/Images/blob/main/CarCatalog/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-07-08%20at%2017.50.00.png" width="160"/> | <img src="https://github.com/lamaks3/Images/blob/main/CarCatalog/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-07-08%20at%2017.50.31.png" width="160"/> | <img src="https://github.com/lamaks3/Images/blob/main/CarCatalog/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-07-08%20at%2017.50.23.png" width="160"/> | <img src="https://github.com/lamaks3/Images/blob/main/CarCatalog/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-07-08%20at%2017.48.48.png" width="160"/> | <img src="https://github.com/lamaks3/Images/blob/main/CarCatalog/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-07-08%20at%2017.52.28.png" width="160"/> |
## 🏗 Code Structure Overview

The project is modularized into distinct folders to strictly follow the MVVM architecture and Separation of Concerns:

- **`App/`**: Contains the application entry point (`CarCatalogApp.swift`) and UI Assets.
- **`Models/`**: Contains the core domain models (`Car`, `PriceFilter`).
- **`Services/`**: Handles all data persistence and mapping. It contains the Core Data database file (`CarDataModel`), `CoreDataManager`, `CoreDataCarRepository`, and `Car+Mapping.swift` to translate between the database entities and local UI models.
- **`ViewModel/`**: Contains `ViewModel.swift` (featuring `CatalogViewModel`), which acts as the bridge between the UI and the Services. It handles business logic, state management, and data binding via Combine.
- **`Views/`**: Contains all SwiftUI views:
  - `ContentView`: Main TabView wrapper.
  - `CatalogView`: The main list of cars with sorting and filtering menus.
  - `FavoriteView`: Dedicated tab for favorite cars.
  - `CarDetailView`: Shows detailed car information.
  - `AddCarView`: A form with validation to add new records.

## 📋 Requirements
- **iOS 16.0+**
- **Xcode 14.0+**
- **Swift 5.0+**
