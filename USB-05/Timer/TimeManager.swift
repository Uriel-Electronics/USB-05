//
//  TimerManager.swift
//  USB-05
//
//  Created by 이요섭 on 6/26/24.
//

import SwiftUI
import Combine

class TimeManager: ObservableObject {
    @Published var currentDate: Date = Date()
    
    var timer: AnyCancellable?
    
    init() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] date in self?.currentDate = date })
    }
}

