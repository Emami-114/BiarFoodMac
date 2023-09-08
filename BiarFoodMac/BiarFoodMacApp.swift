//
//  BiarFoodMacApp.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI
import Firebase




@main
struct BiarFoodMacApp: App {
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
   
        .commands {
            SidebarCommands()
            }
        
        .windowResizability(.contentSize)
//        .windowStyle(.hiddenTitleBar)
//        .windowToolbarStyle(.unified(showsTitle: true))
        
    }
}
