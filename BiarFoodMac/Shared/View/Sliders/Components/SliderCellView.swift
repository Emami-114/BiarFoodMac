//
//  SliderCellView.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import SwiftUI
import Kingfisher
struct SliderCellView: View {
    let slider: Slider
    var sliderEdit: () -> Void
    var sliderRemove: () -> Void
    @State var onHover: Bool = false
    @State var removeButtomHover: Bool = false
    @State var editButtomHover: Bool = false

    
    var body: some View {
        ZStack(alignment: .bottom){
            KFImage(URL(string: slider.imageUrl))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.9)
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 350)
                .cornerRadius(15)
                .clipped()
            
            VStack{
                HStack{

                    Spacer()

                        
                    Rectangle().fill(slider.isPublich ? .green : .red)
                        .frame(width: 30,height: 170)
                        .rotationEffect(Angle(degrees: 130))
                        .offset(x: -40,y: -45)
                        .overlay(content: {
                            Text(slider.isPublich ? "Öffentlich"  : "Privat")
                                .frame(width: 100)
                                .font(.title2)
                                .rotationEffect(Angle(degrees: 40))
                                .offset(x: -34,y: -40)

                        })

                }
                    
                Spacer()
                
                
                VStack(alignment: .leading,spacing: 5){
                    if onHover{
                        HStack(spacing: 15){
                            Button{
                                sliderEdit()
                            }label: {
                               Image(systemName: "square.and.pencil")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(width: 50,height: 50)
                                    .background(editButtomHover ? Color.primary.opacity(0.4) : Color.primary.opacity(0.15))                                    .cornerRadius(10)
                                    
                            }.buttonStyle(.plain)
                                .help("Slider Bearbeiten")
                                .onHover { onHover in
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        self.editButtomHover = onHover
                                    }
                                }
                            Button(role: .destructive){
                                sliderRemove()
                            }label: {
                                Image(systemName: "trash")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                    .frame(width: 50,height:50)
                                    .background(removeButtomHover ? Color.primary.opacity(0.4) : Color.primary.opacity(0.15))
                                    .cornerRadius(10)
                                    
                            }.buttonStyle(.plain)
                                .help("slider Löschen")
                                .onHover { onHover in
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        self.removeButtomHover = onHover
                                    }
                                }
                        }.padding()
                    }else{
                        Text(slider.title)
                            .font(.title)
                            .fontWeight(.semibold)
                        Text(slider.desc)
                    }
                    
                   
                }.padding(.leading,8)
                .padding(5)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .cornerRadius(15)
                
            }
        }.frame(maxWidth: 600,maxHeight: 350)
            .clipped()
            .onHover { onHover in
                withAnimation(.spring()){
                    self.onHover = onHover

                }
            }
    }
}

struct SliderCellView_Previews: PreviewProvider {
    static var previews: some View {
        SliderCellView(slider: .init(title: "Slider Title", desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/biarfood-77cad.appspot.com/o/slider_images%2F5579A56B-568A-4801-A2ED-4475851C8B0E?alt=media&token=2d6aade4-3dde-4738-acf4-ed9a59fcde73", isPublich: false), sliderEdit: {},sliderRemove: {})
    }
}
