//
//  Order.swift
//  BiarFoodMac
//
//  Created by Ecc on 26/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Order: Codable{
    @DocumentID var id: String?
    let userId: String
    let successful: Bool
    let customerName: String
    let customerAdress: String
    let customerZip: String
    let customerCity: String
    let deliveryDate: Date?
    let paymentType: String
    let paymentSuccess: Bool
    let email: String
    let invoiceNum: String
    let totalPrice: Double
    let deliveryAddressDifferent : Bool
    let products : [OrderProduct]
    var createdAt : Timestamp = Timestamp()

}
struct OrderProduct: Codable{
    let id: String
    let name: String
    let quantity: Int
    let netWeight: String
    let depositType: String?
    let depositPrice: Double?
    let imageUrl: String
    let price: Double
    let tax: Int
    
}
var orderExammple = Order(userId: "", successful: true, customerName: "Abdul Emami", customerAdress: "Stauffenbergstr.14", customerZip: "07747", customerCity: "Jena", deliveryDate: Date(), paymentType: "Paypal", paymentSuccess: true, email: "emami@test.de",invoiceNum: "533552",totalPrice: 12.0,deliveryAddressDifferent: false,products: [OrderProduct(id: "", name: "Bier", quantity: 2, netWeight: "330g", depositType: "Mehrweg", depositPrice: 3.30, imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/biarfood-77cad.appspot.com/o/product_images%2F141456CA-0873-4C75-BB12-BCED6D22E475?alt=media&token=9805d806-4299-4d47-a954-fb85c971e8bc", price: 13.90, tax: 19)])
