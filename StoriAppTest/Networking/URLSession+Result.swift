//
//  URLSession+Result.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case noData
    case custom(Error)
    case invalidURL
    case requestFailed(Int)
    case decodingError(Error)
}

extension URLSession {
    func dataTask<T: Decodable>(with request: URLRequest, result: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: request) { data, response, error in
            if let error = error {
                result(.failure(NetworkError.custom(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                result(.failure(NetworkError.invalidResponse))
                return
            }
            guard let data = data else {
                result(.failure(NetworkError.noData))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                result(.success(decodedData))
            } catch {
                result(.failure(error))
            }
        }
        return task
    }
}
