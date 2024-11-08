//
//  HomeRouter.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This layer is responsible for handling navigation logic: Pushing, 
//  Popping, Presenting UIViewControllers.
//
//  This file was generated by the IsaiinDev's iOS Templates so
//  you can apply clean architecture to your iOS projects.
//

import UIKit

protocol HomeRoutingLogic {
    func routeToMovieDetail(movie: Home.TopRatedMoviesUseCase.Result)
}

class HomeRouter: Router, HomeRoutingLogic {
	lazy var view: HomeViewController = {
		return self._view as! HomeViewController
	}()

    func routeToMovieDetail(movie: Home.TopRatedMoviesUseCase.Result) {
        let controller = MovieDetailViewController()
        controller.movie = movie
        controller.hidesBottomBarWhenPushed = true
        self.view.navigationController?.pushViewController(controller, animated: true)
    }
}
