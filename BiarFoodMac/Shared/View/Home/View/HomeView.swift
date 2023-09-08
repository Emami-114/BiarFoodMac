//
//  HomeViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var sidebarPresent : NavigationSplitViewVisibility = .automatic
    var body: some View {
        NavigationSplitView(sidebar: {
            SidebarView()

        }, detail: {
            switch viewModel.selectedTab {
            case "Dashboard" : DashboardView()
            case "Produkt" : Products()
            case "Sliders" : SlidersMainView()
            case "Users" : UsersListView()
            case "Bestellung" : Text("Bestellung")
            case "Einstellung" : Text("Einstellung")
            default : Text("")
        }
        })
        .ignoresSafeArea(.all,edges: .all)
        
        .environmentObject(viewModel)
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
