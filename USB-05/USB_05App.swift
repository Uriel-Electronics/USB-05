//
//  USB_05App.swift
//  USB-05
//
//  Created by 이요섭 on 6/26/24.
//

import SwiftUI

@main
struct USB_05App: App {
    var timerManager = TimeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerManager)
        }
    }
}
