//
//  SlidersListView.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import SwiftUI

struct SlidersListView: View {
    @StateObject private var viewModel = SliderViewModel()
    let proxy: CGSize
    @State private var selectedSlider : Slider? = nil
    @State var showRemoveAlert = false
    @State var showEditView = false
    
    var body: some View {
        HSplitView(){
            
            GeometryReader {proxy2 in
                VStack {
                        ScrollView(.vertical){
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: proxy2.size.width < 700 ? 1 : proxy2.size.width < 1000 ? 2 : 3)) {
                                
                                ForEach(viewModel.sliders ?? [],id: \.id) { slider in
                                    SliderCellView(slider: slider,sliderEdit: {
                                        
                                        withAnimation(.spring()){
                                            self.showEditView = true

                                        }
                                        self.selectedSlider = slider
                                    },sliderRemove: {
                                        withAnimation(.spring()){
                                            self.showRemoveAlert = true
                                               
                                        }
                                        self.selectedSlider = slider
                                    })

                                }
                            }
                        }
                    
                }.padding()
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
            }
            if showEditView{
                if let selectedSlider = selectedSlider{
                    SliderEditView(slider: selectedSlider, showEditView: $showEditView)
                        .frame(maxHeight: .infinity)
                        .frame(minWidth: 500,maxWidth: 600)
                }
            }
        }
     
        .alert(isPresented: $showRemoveAlert) {
            Alert(title: Text("Slider Löschen"), primaryButton: .destructive(Text("Löschen"),action: {
                viewModel.deleteSlider(with: selectedSlider?.id ?? "", imageUrl: selectedSlider?.imageUrl ?? "")
            }), secondaryButton: .cancel())
        }
    }
}

struct SlidersListView_Previews: PreviewProvider {
    static var previews: some View {
        SlidersListView(proxy: .zero)
    }
}
