//
//  SliderRepository.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import Foundation
import Combine
class SliderRepository{
    
    static let shared = SliderRepository()
    
    var sliders = CurrentValueSubject<[Slider]?,Never>(nil)
    
}

extension SliderRepository{
    func createSlider(title: String,desc:String,imageUrl: String,isPublich: Bool){
        let sliderRef = FirebaseManager.shared.database.collection("sliders")
        
        let slider = Slider(title: title, desc: desc,imageUrl: imageUrl,isPublich: isPublich)
        
        do{
            try sliderRef.addDocument(from: slider)
        }catch{
            print("Fehler beim erstellen von Slider: \(error.localizedDescription)")
        }
    }
    
    
    func fetchSliders(){
        FirebaseManager.shared.database.collection("sliders")
            .addSnapshotListener { querySnapshot, error in
                if let error = error{
                    print("Fehler beim laden Sliders: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("Fehler beim laden sliders")
                    return}
                
                let sliders = documents.compactMap { queryDocument -> Slider? in
                   let slider = try? queryDocument.data(as: Slider.self)
                    return slider
                }
                self.sliders.send(sliders)
            }
    }
    
    
    func updateSlider(with id: String,title: String,desc:String,imageUrl: String,isPublich: Bool) {
        let data: [String: Any] = [
            "title" : title,
            "desc" : desc,
            "imageUrl" : imageUrl,
            "isPublich": isPublich ]
        
        
        FirebaseManager.shared.database.collection("sliders").document(id).setData(data, merge: true){error in
            if let error = error{
                print("Slider wurde nicht aktualisiert", error.localizedDescription)
                return
            }
        }
    }
    
    
    func deleteSlider(with id: String) {
        FirebaseManager.shared.database.collection("sliders").document(id).delete(){error in
            if let error {
                print("Slider kann nicht gelöscht werden",error.localizedDescription)
                return
            }
        }
    }
    
}
