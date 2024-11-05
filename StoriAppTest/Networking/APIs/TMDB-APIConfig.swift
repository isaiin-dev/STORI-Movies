//
//  TMDB-APIConfig.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import Foundation

struct TMDB_APIConfig {
    static let baseURL = URL(string: "https://api.themoviedb.org/3")!
    static let apiKey = "97437a2e8f5833c9d0cb1ad27af3e3d1"
    static let apiKeyReadAccess = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NzQzN2EyZThmNTgzM2M5ZDBjYjFhZDI3YWYzZTNkMSIsIm5iZiI6MTczMDc3NTM3OC43MjE5ODM0LCJzdWIiOiI2MThiNjEwZjUzNDY2MTAwNDQ3MTMwYzEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.iyMk3IJ2s3m4jbSKHteiMLFi1MMrgTvvCHssAMzP2hQ"
    static let language = "es-ES"
}

enum MovieDBEndpoint: EndpointType {
    case topRatedMovies(page: Int)
    case movieDetails(movieID: Int)
    case movieCredits(movieID: Int)

    var baseURL: URL {
        return TMDB_APIConfig.baseURL
    }

    var path: String {
        switch self {
        case .topRatedMovies:
            return "/movie/top_rated"
        case .movieDetails(let movieID):
            return "/movie/\(movieID)"
        case .movieCredits(let movieID):
            return "movie/\(movieID)/credits"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .topRatedMovies, .movieDetails, .movieCredits:
            return .get
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer \(TMDB_APIConfig.apiKeyReadAccess)"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .topRatedMovies(let page):
            return ["page": page]
        case .movieDetails:
            return nil
        case .movieCredits(movieID: _):
            return nil
        }
    }
}
