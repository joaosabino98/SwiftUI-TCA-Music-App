//
//  HomeView.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 21/06/2023.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List {
                Section {
                    ImageSliderView(store: Store(initialState: ImageSliderFeature.State()) {
                        ImageSliderFeature()
                            ._printChanges()
                    })
                        .frame(height: 200)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                if let headline = viewStore.headline {
                    Section {
                        Text(headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple.opacity(0.6))
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                Section {
                    GridView_alt()
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Music")
            .onAppear {
                viewStore.send(.newsRequest)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: Store(initialState: HomeFeature.State()) {
            HomeFeature()
        })
    }
}
