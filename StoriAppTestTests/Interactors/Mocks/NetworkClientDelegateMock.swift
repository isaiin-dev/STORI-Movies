//
//  NetworkClientDelegateMock.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 05/11/24.
//

import Foundation
@testable import STORI_Movies

class NetworkClientDelegateMock: NetworkClientDelegate {
    var shouldReturnError = false
    var mockResponse: Home.TopRatedMoviesUseCase.Response?

    func performRequest<T: Codable>(_ endpoint: EndpointType, completion: @escaping (Result<T, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NetworkError.invalidURL))
        } else if let response = mockResponse as? T {
            completion(.success(response))
        } else {
            completion(.failure(NetworkError.invalidResponse))
        }
    }
}
