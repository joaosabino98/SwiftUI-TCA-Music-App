//
//  ImageSliderView.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 21/06/2023.
//

import SwiftUI
import ComposableArchitecture

struct ImageSliderView: View {
    
    // 1
    let store: StoreOf<ImageSliderFeature>
    
    @State var _position: Int = 0
    
    init(store: StoreOf<ImageSliderFeature>) {
        self.store = store
    }
    
    var body: some View {
        // 2
        WithViewStore(store, observe: { $0 }) { viewStore in
            GeometryReader { geometry in
                TabView(selection: viewStore.binding(
                    get: \.sliderPosition,
                    send: .sliderPositionChanged)) {
                        ForEach(Array(zip(viewStore.images, viewStore.images.indices)), id: \.1) { item, index in
                            Image(item)
                                .resizable()
                                .scaledToFill()
//                                .frame(width: geometry.size.width)
                                .clipped()
                                .tag(index)
                        }
                    }
                
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 200)
            }
            .onAppear {
                viewStore.send(.startTimer)
            }
            .onDisappear {
                viewStore.send(.stopTimer)
            }
        }
    }
}

struct ImageSliderView_Previews: PreviewProvider {
    @State static var selection: Int = 0
    static var previews: some View {
        // 4
        ImageSliderView(store: Store(initialState: ImageSliderFeature.State()) {
            ImageSliderFeature()
        })
    }
}
