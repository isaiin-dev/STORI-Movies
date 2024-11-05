//
//  PresenterMock.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 05/11/24.
//

import Foundation
@testable import STORI_Movies

class PresenterMock: HomePresentationLogic {
    var didCallPresentMoviesResponse = false
    var didCallPresentFailure = false
    var receivedMovies: Home.TopRatedMoviesUseCase.Response?
    var receivedErrorMessage: String?

    func presentMoviesResponse(response: Home.TopRatedMoviesUseCase.Response) {
        didCallPresentMoviesResponse = true
        receivedMovies = response
    }

    func presentFailure(message: String) {
        didCallPresentFailure = true
        receivedErrorMessage = message
    }
}
