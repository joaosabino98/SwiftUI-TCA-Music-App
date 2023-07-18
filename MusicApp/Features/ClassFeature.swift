//
//  ClassFeature.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 05/07/2023.
//

import Foundation
import ComposableArchitecture

struct Class: Equatable, Identifiable {
    let id: UUID
    let name: String
    let teacher: String
    let isOnline: Bool
    let latitude: Double?
    let longitude: Double?
}

struct ClassFeature: ReducerProtocol {
    struct State: Equatable {
        var classes: IdentifiedArrayOf<Class>
//        var path
        
    }
    enum Action {
        
    }
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}
