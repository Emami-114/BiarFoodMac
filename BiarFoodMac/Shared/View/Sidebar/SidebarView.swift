//
//  SiderbarView.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var homeViewModel : HomeViewModel
    var body: some View {
        NavigationView {
                VStack(spacing: 10){
                    
                    TabButton(image: "rectangle.3.group", title: "Dashboard", selectedTab: $homeViewModel.selectedTab)
                    
                    
                    TabButton(image: "basket", title: "Produkt", selectedTab: $homeViewModel.selectedTab)
                    
                    TabButton(image: "slider.horizontal.below.square.and.square.filled", title: "Sliders", selectedTab: $homeViewModel.selectedTab)
                    
                    TabButton(image: "person.3", title: "Users", selectedTab: $homeViewModel.selectedTab)
                    TabButton(image: "cart", title: "Bestellung", selectedTab: $homeViewModel.selectedTab)
                    
                    Spacer()
                    TabButton(image: "gear", title: "Einstellung", selectedTab: $homeViewModel.selectedTab)
                
                }
                .padding()
                .padding(.top,35)
                .background(BlurView())
//                .frame(minWidth: 100,minHeight: 300)
                
        }
        
        
    }
}

struct SiderbarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
