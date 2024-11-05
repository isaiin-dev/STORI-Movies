//
//  FavoritesPresenter.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  The presenter is the only layer that communicates with the view 
//  (The rest of layers communicates with the presenter). Basically, 
//  it’s the layer responsible for making decisions based on the 
//  user’s actions sent by The View.
//
//  This file was generated by the IsaiinDev's iOS Templates so
//  you can apply clean architecture to your iOS projects.
//

import Foundation

protocol FavoritesPresentationLogic {
    func present(favorites: [Home.TopRatedMoviesUseCase.Result])
    func presentFailure(message: String)
}

class FavoritesPresenter: Presenter, FavoritesPresentationLogic {
    // MARK: - Properties

    lazy var view: FavoritesDisplayLogic = {
        return self._view as! FavoritesDisplayLogic
    }()

    // MARK: - PresentationLogic implementation

    func present(favorites: [Home.TopRatedMoviesUseCase.Result]) {
        self.view.display(movies: favorites)
    }

    func presentFailure(message: String) {
        self.view.displayFailure(message: message)
    }
}
