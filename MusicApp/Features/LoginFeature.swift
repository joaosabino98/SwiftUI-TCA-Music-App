//
//  LoginFeature.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 17/07/2023.
//

import Foundation
import ComposableArchitecture
//import Dispatch

public struct LoginFeature: ReducerProtocol, Sendable {
    public struct State: Equatable {
        @PresentationState public var alert: AlertState<AlertAction>?
        @BindingState public var email = ""
        public var isFormValid = false
        public var isLoginRequestInFlight = false
        @BindingState public var password = ""
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case alert(PresentationAction<AlertAction>)
        case loginResponse(TaskResult<AuthenticationResponse>)
        case view(View)
        
        public enum View: BindableAction, Equatable {
            case binding(BindingAction<State>)
            case loginButtonTapped
        }
    }
    
    public enum AlertAction: Equatable, Sendable {}
    
    @Dependency(\.authenticationClient) var authenticationClient
    
    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        BindingReducer(action: /Action.view)
        Reduce { state, action in
            switch action {
            case .alert:
                return .none
                
            case let .loginResponse(.success(response)):
                state.isLoginRequestInFlight = false
                return .none
                
            case let .loginResponse(.failure(error)):
                state.alert = AlertState { TextState(error.localizedDescription) }
                state.isLoginRequestInFlight = false
                return .none
                
            case .view(.binding):
                state.isFormValid = !state.email.isEmpty && !state.password.isEmpty
                return .none
                
            case .view(.loginButtonTapped):
                state.isLoginRequestInFlight = true
                return .run { [email = state.email, password = state.password] send in
                    await send(
                        .loginResponse(
                            await TaskResult {
                                try await self.authenticationClient.login(
                                    .init(email: email, password: password)
                                )
                            }
                        )
                    )
                }
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}

