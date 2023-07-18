//
//  MusicApp.swift
//  Music
//
//  Created by Sabino, Joao Gabriel on 21/06/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct MusicApp: App {
    
    let store = Store(initialState: CoreFeature.State()) {
        CoreFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            SwitchStore(self.store) { state in
                switch state {
                case .login:
                    CaseLet(/CoreFeature.State.login, action: CoreFeature.Action.login) { store in
                        NavigationStack {
                            LoginView(store: store)
                        }
                    }
                case .home:
                    CaseLet(/CoreFeature.State.home, action: CoreFeature.Action.home) { store in
                        NavigationStack {
                            HomeView(store: store)
                        }
                    }
                }
            }
        }
    }
}
