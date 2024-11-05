//
//  HomeWorker.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is where we will have direct access to our network layer 
//  (APIManager) and our data persistence layer (DataStore), it is important 
//  that all the functions in this class always return something
//
//  This file was generated by the IsaiinDev's iOS Templates so
//  you can apply clean architecture to your iOS projects.
//

import Foundation

class HomeWorker: NetworkClientDelegate {

    func getTopRatedMovies(page: Int, result: @escaping(Result<Home.TopRatedMoviesUseCase.Response, Error>) -> Void){
        performRequest(MovieDBEndpoint.topRatedMovies(page: page), completion: result)
    }
    
}