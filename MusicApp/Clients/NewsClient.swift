//
//  NewsClient.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 17/07/2023.
//

import Foundation
import ComposableArchitecture

struct NewsClient {
    var fetch: () async throws -> NewsResponse
}

extension NewsClient: DependencyKey {
    static let liveValue: NewsClient = Self {
        var url = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
        url.queryItems = [
            URLQueryItem(name: "category", value: "entertainment"),
//            URLQueryItem(name: "sources", value: "bbc-news"),
            URLQueryItem(name: "country", value: "US"),
            URLQueryItem(name: "apiKey", value: "6470530265ca42aaae9facaa6b96e2e9")
        ]
        
        var request = URLRequest(url: url.url!)
        
        let (data, _) = try await URLSession.shared
            .data(for: request)
        
        var decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
        
        let response = try decoder.decode(NewsResponse.self, from: data)
        print (response)
        return response
        
//        return String(decoding: data, as: UTF8.self)
    }
}

extension DependencyValues {
    var news: NewsClient {
        get { self[NewsClient.self] }
        set { self[NewsClient.self] = newValue }
    }
}

struct Article: Codable, Equatable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: String
    let content: String?
}

struct Source: Codable, Equatable {
    let id: String?
    let name: String
}

struct NewsResponse: Codable, Equatable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
