//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Wouter Verweirder on 02/11/2022.
//

import SwiftUI

@main
struct LandmarksApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
