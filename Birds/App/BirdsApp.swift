//
//  BirdsApp.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import SwiftUI

@main
struct BirdsApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
