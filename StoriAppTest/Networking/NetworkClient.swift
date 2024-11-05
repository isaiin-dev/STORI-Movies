//
//  NetworkClient.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import Foundation

protocol NetworkClientDelegate {
    func performRequest<T: Codable>(_ endpoint: EndpointType, completion: @escaping(Result<T, Error>) -> Void)
}

extension NetworkClientDelegate {
    func performRequest<T: Codable>(_ endpoint: EndpointType, completion: @escaping(Result<T, Error>) -> Void) {
        NetworkClient.shared.performRequest(endpoint, completion: completion)
    }
}

class NetworkClient {
    static let shared: NetworkClient = NetworkClient()
    private let session: URLSession
    
    private init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    func performRequest<T: Codable>(_ endpoint: EndpointType, completion: @escaping(Result<T, Error>) -> Void) {
        var urlComponents = URLComponents(url: endpoint.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)

        var queryItems = [
            URLQueryItem(name: "language", value: TMDB_APIConfig.language)
        ]
        
        if let parameters = endpoint.parameters {
            let additionalQueryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            queryItems.append(contentsOf: additionalQueryItems)
        }

        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let task = session.dataTask(with: request) { (result: Result<T, Error>) in
            switch result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
