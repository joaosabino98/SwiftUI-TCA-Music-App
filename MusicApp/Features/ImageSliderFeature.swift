//
//  ImageSliderFeature.swift
//  MusicApp
//
//  Created by Sabino, Joao Gabriel on 05/07/2023.
//

import Foundation
import ComposableArchitecture

struct BannerImage {
    var name: String
    var position: Int
}

struct ImageSliderFeature: ReducerProtocol {
    struct State: Equatable, Hashable {
        var images = ["artistsBanner", "classesBanner"]
        var sliderPosition = 0
        var isTimerRunning = false
        
    }
    enum Action {
        case timerTick
        case startTimer
        case stopTimer
        case sliderPositionChanged
    }
    
    enum CancelID { case timer }
    @Dependency(\.continuousClock) var clock
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .startTimer:
                if !state.isTimerRunning {
                    state.isTimerRunning = true
                    return .run { send in
                        for await _ in self.clock.timer(interval: .seconds(5)) {
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                } else {
                    return .none
                }
                
            case .stopTimer:
                if state.isTimerRunning {
                    state.isTimerRunning = false
                    return .cancel(id: CancelID.timer)
                } else {
                    return .none
                }
                
            case .timerTick:
                state.sliderPosition = (state.sliderPosition + 1) % state.images.count
                return .none
                
            case .sliderPositionChanged:
                return .none
            }
        }
    }
}
