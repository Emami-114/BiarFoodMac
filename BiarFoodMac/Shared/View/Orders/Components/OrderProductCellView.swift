//
//  OrderProductCellView.swift
//  BiarFoodMac
//
//  Created by Ecc on 26/09/2023.
//

import SwiftUI
import Kingfisher
struct OrderProductCellView: View {
    let orderProduct : OrderProduct
    var body: some View {
        HStack(spacing: 30){
            KFImage(URL(string: orderProduct.imageUrl))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.9)
                .resizable()
                .scaledToFill()
                .frame(width: 50,height: 50)
                .cornerRadius(5)
                .clipped()
            
            VStack(alignment: .leading,spacing: 10){
                HStack(alignment: .center){
                    Text("Name:")
                    Text(orderProduct.name.trimmingCharacters(in: .whitespacesAndNewlines))
                        .font(.headline)
                }
                HStack{
                    Text("Stück:")
                    Text("\(orderProduct.quantity)")
                        .font(.headline)

                }
            }.frame(maxWidth: .infinity,alignment: .leading)
            Spacer()
            VStack(alignment: .leading,spacing: 10){
                HStack{
                    Text("Nettogewicht:")
                    Text(orderProduct.netWeight)
                        .font(.headline)
                    Spacer()
                }
                HStack{
                    Text("Preise:")
                    Text("\(priceReplacingWithComma(_: orderProduct.price))€")
                        .font(.headline)
                    Spacer()

                }
            }.frame(maxWidth: .infinity,alignment: .leading)
            Spacer()
            if orderProduct.depositType != nil && !((orderProduct.depositType?.isEmpty) == nil) {
                VStack(alignment: .leading,spacing: 10){
                    HStack{
                        Text("Pfand:")
                        Text(orderProduct.depositType ?? "")
                            .font(.headline)

                    }
                    HStack{
                        Text("Pfand preise:")
                        Text("\(priceReplacingWithComma(_: orderProduct.depositPrice ?? 0.0))€")
                            .font(.headline)
                    }
                }.frame(maxWidth: .infinity,alignment: .trailing)
            }else {
                VStack(alignment: .leading,spacing: 10){
                    HStack{
                        Text("Pfand:")
                        Text("Mehrwrg")
                            .font(.headline)

                    }
                    HStack{
                        Text("Pfand preise:")
                        Text("\(3.30)€")
                            .font(.headline)
                    }
                }.opacity(0)
                    .frame(maxWidth: .infinity,alignment: .trailing)
            }
            
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    OrderProductCellView(orderProduct: .init(id: "", name: "Bier", quantity: 2, netWeight: "330g", depositType: "Mehrweg", depositPrice: 3.30, imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/biarfood-77cad.appspot.com/o/product_images%2F141456CA-0873-4C75-BB12-BCED6D22E475?alt=media&token=9805d806-4299-4d47-a954-fb85c971e8bc", price: 13.90, tax: 19))
}


