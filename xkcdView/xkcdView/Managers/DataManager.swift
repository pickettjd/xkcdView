//
//  DataManager.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/6/25.
//

import Foundation

enum APIError: Error {
    case invalidURL(String)
    case decodingError(String, underlyingError: Error)
    case serverError(String)
    case other(Error)
}

protocol DataAPI {
    func fetchComic(comicId: Int) async throws -> ComicModel
}

class DataManager: DataAPI {
    let apiURLBase = "https://xkcd.com/"
    
    func fetchComic(comicId: Int) async throws -> ComicModel {
        let urlString = "\(apiURLBase)\(comicId)/info.0.json"
        
        return try await fetch(urlString: urlString)
    }
    
    func fetch<T>(urlString: String) async throws -> T where T: Decodable {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL(urlString)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Fetch
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError("Invalid response from server - Not an HTTP URL Response")
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.serverError("HTTP Error: \(httpResponse.statusCode)")
        }
        
        // Decode
        return try JSONDecoder().decode(T.self, from: data)
    }
    

}

