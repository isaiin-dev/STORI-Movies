//
//  FavoritesManager.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 05/11/24.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favoriteMovies"
    private init() {}

    func loadFavorites() -> [Home.TopRatedMoviesUseCase.Result] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Home.TopRatedMoviesUseCase.Result].self, from: data)
            return favorites
        } catch {
            print("Error al cargar favoritos: \(error)")
            return []
        }
    }

    private func saveFavorites(_ favorites: [Home.TopRatedMoviesUseCase.Result]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Error al guardar favoritos: \(error)")
        }
    }

    func addFavorite(movie: Home.TopRatedMoviesUseCase.Result) {
        var favorites = loadFavorites()
        if !favorites.contains(where: { $0.id == movie.id }) {
            favorites.append(movie)
            saveFavorites(favorites)
        }
    }

    func removeFavorite(movie: Home.TopRatedMoviesUseCase.Result) {
        var favorites = loadFavorites()
        if let index = favorites.firstIndex(where: { $0.id == movie.id }) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }

    func isFavorite(movie: Home.TopRatedMoviesUseCase.Result) -> Bool {
        let favorites = loadFavorites()
        return favorites.contains(where: { $0.id == movie.id })
    }
    
    func toggleFavorite(movie: Home.TopRatedMoviesUseCase.Result) {
       var favorites = loadFavorites()
       if let index = favorites.firstIndex(where: { $0.id == movie.id }) {
           favorites.remove(at: index)
       } else {
           favorites.append(movie)
       }
       saveFavorites(favorites)
   }
}

