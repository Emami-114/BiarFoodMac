//
//  Slider.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Slider : Codable{
    @DocumentID var id: String?
    let title: String
    let desc: String
    let imageUrl: String
    var isPublich: Bool
    var createdAt: Timestamp = Timestamp()
}
