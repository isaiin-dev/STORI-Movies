//
//  FavoritesInteractor.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  The interactor is responsible for managing data from the model layer 
//  (note that Model is not part of the VIPER architecture, feel free to 
//  implement it or not, but for sure it will make our app more concise).
//
//  This file was generated by the IsaiinDev's iOS Templates so
//  you can apply clean architecture to your iOS projects.
//

import Foundation

protocol FavoritesBusinessLogic {
    func fetchFavorites()
    func goToMovieDetail(movie: Home.TopRatedMoviesUseCase.Result)
}

class FavoritesInteractor: Interactor, FavoritesBusinessLogic {
   
    // MARK: - Properties

    let worker = FavoritesWorker()

    lazy var presenter: FavoritesPresentationLogic = {
		return self._presenter as! FavoritesPresentationLogic
	}()

    lazy var router: FavoritesRoutingLogic = {
        return self._router as! FavoritesRoutingLogic
    }()

    // MARK: - BussinesLogic Implementation

    func fetchFavorites() {
        let favorites = FavoritesManager.shared.loadFavorites()
        self.presenter.present(favorites: favorites)
    }

    // MARK: - RoutingLogic Implementation
    
    func goToMovieDetail(movie: Home.TopRatedMoviesUseCase.Result) {
        self.router.routeToMovieDetail(movie: movie)
    }
}