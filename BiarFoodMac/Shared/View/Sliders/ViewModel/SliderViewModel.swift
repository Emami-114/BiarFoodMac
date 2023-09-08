//
//  SliderViewModel.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import Foundation
import Combine
class SliderViewModel: ObservableObject {
    @Published var sliders: [Slider]? = (nil)
    private var cancellables = Set<AnyCancellable>()
    let sliderRepository = SliderRepository.shared
    let storageRepository = StorageRepository.shared
    
    init() {
        sliderRepository.sliders
            .sink{ [weak self] sliders in
                guard let self else {return}
                self.sliders = sliders
            }
            .store(in: &cancellables)
        fetchSlider()
    }
    
    
    func fetchSlider(){
        sliderRepository.fetchSliders()
    }
    
    
    func deleteSlider(with id:String, imageUrl: String) {
        sliderRepository.deleteSlider(with: id)
        if !imageUrl.isEmpty {
            storageRepository.deleteImage(with: imageUrl)
        }
    }
    
}
