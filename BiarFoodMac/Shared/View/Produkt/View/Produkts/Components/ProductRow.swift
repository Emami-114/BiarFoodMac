//
//  ProductRow.swift
//  BiarFoodMac
//
//  Created by Ecc on 22/08/2023.
//

import SwiftUI
import Kingfisher
struct ProductRow: View {
    let product: Product
    @State private var isHover = false
    @State private var progre = false
     var showAlert: () -> Void
    var body: some View {
        
        
        VStack (alignment: .leading){
            ZStack(alignment: .bottom){
              
                KFImage(URL(string: product.imageUrl))
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .fade(duration: 0.9)
                        .resizable()
                        .scaledToFill()
                              
                        .frame(minWidth: 100,minHeight: 150)
                        .cornerRadius(15)
                        .clipped()
              
                
                
                VStack{
                    HStack{
                        if product.sale {
                            Text("%")
                                .font(.title)
                                .padding(8)
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
                    
                    
                    Spacer()

                    if isHover {
                        VStack{
                            HStack(spacing: 20){
                                switch product.available {
                                case true : Text("Vorrätig")
                                        .font(.title3.bold())
                                case false : HStack{
                                    Text("Stück:")
                                    Text("\(product.availableAmount )")
                                }
                                        .font(.title3.bold())

                                }
                                
                                Button{
                                    showAlert()
                                }label: {
                                    Image(systemName: "trash")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .padding(.horizontal,8)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(.red))
                                        .shadow(radius: 5)

                                }.buttonStyle(.plain)
                                    .help("Sie können das produkt Löschen")

                            }
                           
                            HStack{
                                Text("Erstellt Datum:")
                                    .font(.caption)
                                Text("\(product.createdAt.dateValue().formatted(date: .abbreviated, time: .omitted))")
                                    .font(.caption)

                            }
                            .padding(.top,0)
                        }
                        .padding()
                            .frame(maxWidth: .infinity,maxHeight: 60)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.regularMaterial))
                    }
                  
                }
    
            }
           
            
            VStack(alignment: .leading,spacing: 5){
                Text(product.title)
                    .padding(.vertical,0)
                HStack{
                    Text("Artikelnummer:")
                        .font(.caption)
                    Text("\(product.articleNumber )")
                }
                    
                if product.sale {
                        HStack{
                            Text("\(priceReplacingWithComma(_:product.price))€")
                                .font(.body.bold())
                                .strikethrough(true,pattern: .solid,color: .red)
                                
                            
                            Text("\(priceReplacingWithComma(_: product.salePrice))€")
                                .font(.title2.bold())
                        }
                        
                            
                    } else {
                        Text("\(priceReplacingWithComma(_:product.price))€")
                            .font(.title2.bold())
                    }
                
                
             
                
                HStack{
                    Text("kategorien:")
//                    Text(product.categorie )
//                        .foregroundColor(.blue)
                }
                
            }.padding(.horizontal)
        }
        
        .frame(minWidth: 150,minHeight: 250)
        .cornerRadius(15)
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 15).strokeBorder(lineWidth: 1).opacity(0.5))
        .clipped()
        .onHover { hover in
            isHover = hover
    }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: .init(title: "", desc: "", price: 0.0, categorie: [], brand: "", sale: false, salePrice: 0.0, unit: "", imageUrl: "", unitAmountPrice: "", tax: 0, articleNumber: "", available: false, availableAmount: 0, deposit: false, depositType: "", depositPrice: 0.0, netFillingQuantity: "", alcoholicContent: "", nutriScore: "", ingredientsAndAlegy: "", madeIn: "", referencePoint: "", calorificKJ: "", caloricValueKcal: "", fat: "", fatFromSour: "", carbohydrates: "", CarbohydratesFromSugar: "", protein: "", salt: "", additionallyWert: "",isCold: false,isPublic: true,adult: false,minimumAge: 0),showAlert: {})
    }
}

