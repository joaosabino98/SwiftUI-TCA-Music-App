//
//  LoginView.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 17/07/2023.
//

import Foundation
import ComposableArchitecture
import SwiftUI

public struct LoginView: View {
    let store: StoreOf<LoginFeature>
    
    struct ViewState: Equatable {
        @BindingViewState var email: String
        var isActivityIndicatorVisible: Bool
        var isFormDisabled: Bool
        var isLoginButtonDisabled: Bool
        @BindingViewState var password: String
    }
    
    public init(store: StoreOf<LoginFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: \.view, send: { .view($0) }) { viewStore in
            Form {
                Text(
          """
          To login use any email and "password" for the password.
          """
                )
                
                Section {
                    TextField("blob@pointfree.co", text: viewStore.$email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                    
                    SecureField("••••••••", text: viewStore.$password)
                }
                
                Button {
                    // NB: SwiftUI will print errors to the console about "AttributeGraph: cycle detected" if
                    //     you disable a text field while it is focused. This hack will force all fields to
                    //     unfocus before we send the action to the view store.
                    // CF: https://stackoverflow.com/a/69653555
                    _ = UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
                    )
                    viewStore.send(.loginButtonTapped)
                } label: {
                    HStack {
                        Text("Log in")
                        if viewStore.isActivityIndicatorVisible {
                            Spacer()
                            ProgressView()
                        }
                    }
                }
                .disabled(viewStore.isLoginButtonDisabled)
            }
            .disabled(viewStore.isFormDisabled)
            .alert(store: self.store.scope(state: \.$alert, action: LoginFeature.Action.alert))
        }
        .navigationTitle("Login")
    }
}

extension BindingViewStore<LoginFeature.State> {
    var view: LoginView.ViewState {
        LoginView.ViewState(
            email: self.$email,
            isActivityIndicatorVisible: self.isLoginRequestInFlight,
            isFormDisabled: self.isLoginRequestInFlight,
            isLoginButtonDisabled: !self.isFormValid,
            password: self.$password
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView(
                store: Store(initialState: LoginFeature.State()) {
                    LoginFeature()
                } withDependencies: {
                    $0.authenticationClient.login = { _ in
                        AuthenticationResponse(token: "deadbeef", twoFactorRequired: false)
                    }
                    $0.authenticationClient.twoFactor = { _ in
                        AuthenticationResponse(token: "deadbeef", twoFactorRequired: false)
                    }
                }
            )
        }
    }
}
