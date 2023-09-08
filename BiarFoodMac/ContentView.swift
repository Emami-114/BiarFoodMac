//
//  ContentView.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI


var screenSize = NSScreen.main!.visibleFrame
struct ContentView: View {
    var body: some View {
        
          HomeView()
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
