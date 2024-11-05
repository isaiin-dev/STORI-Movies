//
//  ImageLoader.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 05/11/24.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let imageCache = NSCache<NSURL, UIImage>()
    private let queue = DispatchQueue(label: "com.storimovies.imageloader", attributes: .concurrent)
    private let session: URLSession

    private init(session: URLSession = .shared) {
        self.session = session
    }
}

extension ImageLoader {
    typealias ImageCompletion = (Result<UIImage, Error>) -> Void

    func loadImage(from url: URL, completion: @escaping ImageCompletion) {
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            completion(.success(cachedImage))
            return
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let self = self, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            self.imageCache.setObject(image, forKey: url as NSURL)

            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        task.resume()
    }
}
