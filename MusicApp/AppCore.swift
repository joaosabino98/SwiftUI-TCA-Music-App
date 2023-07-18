//
//  AppCore.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 17/07/2023.
//

import ComposableArchitecture
import Dispatch

struct CoreFeature: ReducerProtocol {
    enum State: Equatable {
        case login(LoginFeature.State)
        case home(HomeFeature.State)
        
        public init() { self = .login(LoginFeature.State()) }
    }
    
    enum Action: Equatable {
        case login(LoginFeature.Action)
        case home(HomeFeature.Action)
    }
    
    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .login(.loginResponse(.success(_))):
                state = .home(HomeFeature.State())
                return .none
                
            case .login:
                return .none
                
            case .home(.logoutButtonTapped):
                state = .login(LoginFeature.State())
                return .none
                
            case .home:
                return .none
            }
        }
        .ifCaseLet(/State.login, action: /Action.login) {
            LoginFeature()
        }
        .ifCaseLet(/State.home, action: /Action.home) {
            HomeFeature()
        }
    }
}
