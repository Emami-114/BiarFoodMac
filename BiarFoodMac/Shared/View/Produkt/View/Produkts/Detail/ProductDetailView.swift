//
//  ProductDetailView.swift
//  BiarFoodMac
//
//  Created by Ecc on 24/08/2023.
//

import SwiftUI
import Kingfisher
struct ProductDetailView: View {
    let product: Product
    @Binding var showEditView : Bool
    @Binding var showDetailView : Bool
    @State private var pickerSelected = "Beschreibung"
    var body: some View {
        VStack {
            HStack{
                Button{
                    withAnimation(.easeInOut(duration: 1)){
                        showDetailView = false
                    }
                }label: {
                    Image(systemName: "xmark")
                        .font(.title)
                }.buttonStyle(.plain)
                Spacer()
                Button{
                    withAnimation(.easeInOut(duration: 1)){
                        showEditView = true

                    }
                }label: {
                    Text("Bearbeiten")
                }
            }.padding()
            Spacer()
            
            ScrollView(.vertical) {
                VStack(alignment: .center,spacing: 10){
                    ZStack {
                        
                        KFImage(URL(string: product.imageUrl))
                                .loadDiskFileSynchronously()
                                .cacheMemoryOnly()
                                .fade(duration: 2.5)
                                .resizable()
                                .frame(maxWidth: 400,maxHeight: 400)
                                .cornerRadius(25)
                            .clipped()
                        
                    VStack{
                        HStack{
                            if product.sale {
                                Text("%")
                                    .font(.title.bold())
                                    .padding(12)
                                    .background(Circle().fill(.red))
                            }
                            
                            Spacer()
                            switch product.available{
                            case true : Circle()
                                    .fill(.green)
                                    .frame(width: 20,height: 20)
                                    .shadow(color: .black.opacity(0.8),radius: 5)
                            case false: if product.availableAmount > 0 {
                                Circle()
                                        .fill(.yellow)
                                        .frame(width: 20,height: 20)
                                        .shadow(color: .black.opacity(0.8),radius: 5)
                            }else {
                                Circle()
                                        .fill(.red)
                                        .frame(width: 20,height: 20)
                                        .shadow(color: .black.opacity(0.8),radius: 5)
                            }
                          
                            }
                        }.padding()
                            .padding(.horizontal)
                        Spacer()
                      
                    }
                    }

                    
                    if !(product.nutriScore.isEmpty ){
                        NutriComponent(product: product)
                    }
                    
                    VStack(alignment: .leading,spacing: 10){
                        if product.deposit {
                            HStack(spacing: 10){
                                Text(product.depositType )
                                    .font(.title.bold())
                                Spacer()
                                Text(priceReplacingWithComma(product.depositPrice) + "€ Pfand")
                                    .font(.title2.bold())
                                
                            }
                        }
                        
                        Text(product.title)
                            .font(.title2)
                        
                        HStack{
                            HStack{
                                Text("Artikelnummer:")
                                Text(product.articleNumber )
                                    .font(.title3)
                            }
                            Spacer()
                            HStack{
                                Text("Kategorien:")

                            }
                        }
                        
                        if product.sale {
                            HStack{
                                Text("\(priceReplacingWithComma(_: product.price))€")
                                    .font(.title.bold())
                                    .strikethrough(true,pattern: .solid,color: .red)
                                    
                                
                                Text("\(priceReplacingWithComma(_: product.salePrice))€")
                                    .font(.title.bold())
                            }
                            
                                
                        } else {
                            Text("\(priceReplacingWithComma(_: product.price))€")
                                .font(.title.bold())
                        }
                        
                      
                        
                    }.padding(.horizontal)
                    
                    Picker("", selection: $pickerSelected) {
                        Text("Beschreibung").tag("Beschreibung")
                        Text("Zutaten & Allergene").tag("Zutaten & Allergene")
                        Text("Nährwerte").tag("Nährwerte")
                        Text("Artikeldetails").tag("Artikeldetails")
                    }.pickerStyle(.segmented)
                    
                    switch pickerSelected {
                    case "Beschreibung" : Text(product.desc)
                                            .font(.body)
                    case "Zutaten & Allergene" : Text(product.ingredientsAndAlegy)
                            .font(.body)
                    case "Nährwerte" : neahWert(product: product)
                    case "Artikeldetails": Text(product.madeIn)


                    default:
                        Text("")
                    }
                    
                    
                    
                }
            }
        }.padding()
        .frame(minWidth: 500)
            .background(BlurView().ignoresSafeArea(.all,edges: .all))
        
        
        
    }

}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: .init(title: "", desc: "", price: 0.0, categorie: [],brand: "", sale: false, salePrice: 0.0, unit: "", imageUrl: "", unitAmountPrice: "", tax: 0, articleNumber: "", available: false, availableAmount: 0, deposit: false, depositType: "", depositPrice: 0.0, netFillingQuantity: "", alcoholicContent: "", nutriScore: "", ingredientsAndAlegy: "", madeIn: "", referencePoint: "", calorificKJ: "", caloricValueKcal: "", fat: "", fatFromSour: "", carbohydrates: "", CarbohydratesFromSugar: "", protein: "", salt: "", additionallyWert: "",isCold: false,isPublic: true,adult: false,minimumAge: 0),showEditView: .constant(false),showDetailView: .constant(false))
            .frame(height: 800)
    }
}
