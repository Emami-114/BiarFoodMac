//
//  CreateSliderView.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import SwiftUI

struct CreateSliderView: View {
    @StateObject private var viewModel = SliderAddViewModel()
    @State var isHoverChoosePhoto = false
    @State var isHoverCreateButton = false
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 30){
                Image(nsImage: viewModel.selectedImage ?? NSImage())
                    .resizable()
                    .frame(minWidth: 150,minHeight: 150)
                    .frame(maxWidth: 250,maxHeight: 250)
                    .cornerRadius(25)
                
                Button{
                    viewModel.choosePhoto()
                }label: {
                    Text("Bild auswählen")
                        .frame(minWidth: 50,maxWidth: 150)
                        .frame(height: 40,alignment: .center)
                        .background(isHoverChoosePhoto ? Color.primary.opacity(0.5) : Color.primary.opacity(0.2))
                        .cornerRadius(10)
                }.buttonStyle(PlainButtonStyle())
                    .onHover { isHover in
                        withAnimation(.spring()){
                            isHoverChoosePhoto = isHover

                        }
                    }
                Toggle("Öffentlich", isOn: $viewModel.isPublic)

                TextFieldSingle(title: "Title", text: $viewModel.title)
                TextEditSingle(title: "Beschreibung", text: $viewModel.desc)
                
                    .toast(isShowing: $viewModel.uploadComplete,text: "Slider erfolgreich erstellt")
                
                Button{
                    Task{
                        try await viewModel.createSlider()
                        viewModel.clearFields()
                    }
                }label: {
                    VStack{
                        Text("Slider erstellen")
                        if viewModel.uploadProgress > 0 && viewModel.uploadProgress < 1 {
                            ProgressView()
                        }
                    }
                        .frame(minWidth: 60,maxWidth: 160)
                        .frame(height: 50,alignment: .center)
                    
                        .background(isHoverCreateButton ? Color.primary.opacity(0.5) : Color.primary.opacity(0.2))
                        .cornerRadius(15)

                }.buttonStyle(PlainButtonStyle())
                    .onHover { isHover in
                        withAnimation(.spring()){
                            isHoverCreateButton = isHover

                        }
                    }

            }
        }.padding()
        
    }
}

struct CreateSliderView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSliderView()
    }
}
