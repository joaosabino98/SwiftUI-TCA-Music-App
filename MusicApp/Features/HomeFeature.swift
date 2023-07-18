//
//  HomeFeature.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 04/07/2023.
//

import Foundation
import ComposableArchitecture

struct HomeFeature: ReducerProtocol {
    struct State: Equatable {
        var headline: String?
//        var path
    }

    enum Action: Equatable {
        case newsRequest
        case newsResponse(NewsResponse)
        case logoutButtonTapped
    }
    
    @Dependency(\.news) var news
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .newsRequest:
                state.headline = nil
                return .run { send in
                    try await send(.newsResponse(self.news.fetch()))
                }
            case let .newsResponse(news):
                state.headline = news.articles[0].title
                return .none
            case .logoutButtonTapped:
                return .none
            }
        }
    }
}

struct News: Equatable, Identifiable {
    var id: UUID
    var title: String
    var body: String
}
