//
//  HTTPClient.swift
//  MoviesApp
//
//  Created by Hina on 2024/04/29.
//  Copyright © 2024 Mohammad Azam. All rights reserved.
//

import Foundation

protocol HTTPClientProtocol {
    func getMovieDetailsBy(imdbId: String, completion: @escaping (Result<MovieDetail, ApiError>) -> Void)
    func getMoviesBy(search: String, completion: @escaping (Result<[Movie]?, ApiError>) -> Void)
}

struct HTTPClient: HTTPClientProtocol {
    enum Endpoint: String {
        case imdbId = "i"
        case name = "s"

        static let baseURL = "http://www.omdbapi.com/"
        static let apiKey = Constants.API_KEY

        func url(for query: String) -> URL? {
            URL(string: "\(Endpoint.baseURL)?\(self.rawValue)=\(query)&apikey=\(Endpoint.apiKey)")
        }
    }
    
    func getMovieDetailsBy(imdbId: String, completion: @escaping (Result<MovieDetail, ApiError>) -> Void) {

        guard let url = Endpoint.imdbId.url(for: imdbId) else {
            return completion(.failure(.urlError))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data, error == nil else {
                return completion(.failure(.responseDataEmpty))
            }

            guard let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
                return completion(.failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "Invalid data")))
            }

            completion(.success(movieDetail))

        }.resume()

    }
    func getMoviesBy(search: String, completion: @escaping (Result<[Movie]?, ApiError>) -> Void) {
        guard let url = Endpoint.name.url(for: search) else {
            return completion(.failure(.urlError))
        }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.responseDataEmpty))
            }

            guard let moviesResponse = try? JSONDecoder().decode(Movies.self, from: data) else {
                return completion(.failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "Invalid data")))
            }
            completion(.success(moviesResponse.movies))
        }.resume()
    }
}
