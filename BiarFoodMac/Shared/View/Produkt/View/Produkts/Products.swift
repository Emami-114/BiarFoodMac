//
//  Products.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI

struct Products: View {
    @State var selectedProductTab = "Alle Produkte"
    @StateObject var categoryViewModel = CategorieViewModel()
    @State var selectedProduct: Product?
    @State private var presentDetailView2 = false
    var body: some View {
        NavigationSplitView(sidebar: {
            VStack{
                TabButton(image: "bag", title: "Alle Produkte", selectedTab: $selectedProductTab)
                TabButton(image: "bag.badge.plus", title: "Erstellen", selectedTab: $selectedProductTab)
                TabButton(image: "rectangle.grid.2x2", title: "Produkt Kategorien", selectedTab: $selectedProductTab)
             
                Spacer()

            }
            .padding()
            .padding(.top,35)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(BlurView().ignoresSafeArea())
        }, detail: {
            switch selectedProductTab {
            case "Alle Produkte" : ProduktListView()
                    .environmentObject(categoryViewModel)
                    
            case "Erstellen" : AddProduktView()
                    .environmentObject(categoryViewModel)
            case "Produkt Kategorien" : CategoriesView( pickerSelected: Category(mainId: "",name: "", desc: "", type: "",imageUrl: ""))
                    .environmentObject(categoryViewModel)
            default : Text("")
        }
        })
           

        
        .ignoresSafeArea(.all,edges: .all)
    }
}

struct Products_Previews: PreviewProvider {
    static var previews: some View {
        Products()
    }
}
