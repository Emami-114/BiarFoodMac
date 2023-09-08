//
//  SliderEditView.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import SwiftUI
import Kingfisher
struct SliderEditView: View {
    @ObservedObject private var viewModel : SliderEditViewModel
    let slider: Slider
    @Binding var showEditView: Bool
    init(slider: Slider,showEditView: Binding<Bool>){
        self.slider = slider
        self._showEditView = showEditView
        self.viewModel = SliderEditViewModel(slider: slider)
    }
    @State var isHoverChoosePhoto = false
    @State var isHoverCreateButton = false
    var body: some View {
        VStack {
            HStack{
                Button{
                    withAnimation(.spring()){
                        showEditView = false

                    }
                }label: {
                    Image(systemName: "xmark")
                        .font(.title.bold())
                        .padding(9)
                        .background(Color.primary.opacity(0.2))
                        .cornerRadius(10)
                }.buttonStyle(.plain)
                Spacer()
            }
            ScrollView(.vertical){
                VStack(spacing: 30){
                    if viewModel.selectedImage == nil{
                        KFImage(URL(string: slider.imageUrl))
                            .loadDiskFileSynchronously()
                            .cacheMemoryOnly()
                            .fade(duration: 0.9)
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 350)
                            .cornerRadius(15)
                            .clipped()
                    }else{
                        Image(nsImage: viewModel.selectedImage ?? NSImage())
                            .resizable()
                            .frame(minWidth: 150,minHeight: 150)
                            .frame(maxWidth: 250,maxHeight: 250)
                            .cornerRadius(25)
                    }
                   
                    
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
                            isHoverChoosePhoto = isHover
                        }
                    Toggle("Öffentlich", isOn: $viewModel.isPublic)
                    TextFieldSingle(title: "Title", text: $viewModel.title)
                    TextEditSingle(title: "Beschreibung", text: $viewModel.desc)
                    
                        .toast(isShowing: $viewModel.uploadComplete,text: "Slider erfolgreich erstellt")
                    
                    Button{
                        Task{
                            try await viewModel.updateSlider(with: slider.id ?? "")
                            showEditView = false
                        }
                    }label: {
                        VStack{
                            Text("Slider Updaten")
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
                            isHoverCreateButton = isHover
                        }

                }.padding()
            }
        }.padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button{
                        showEditView.toggle()
                    }label: {
                        Image(systemName: "xmark")
                    }
                }
            }
    }
}

struct SliderEditView_Previews: PreviewProvider {
    static var previews: some View {
        SliderEditView(slider: .init(title: "", desc: "", imageUrl: "", isPublich: false), showEditView: .constant(false))
    }
}
