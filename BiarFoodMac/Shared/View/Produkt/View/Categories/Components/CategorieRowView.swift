//
//  CategorieRowView.swift
//  BiarFoodMac
//
//  Created by Ecc on 25/08/2023.
//

import SwiftUI
import Kingfisher
struct CategorieRowView: View {
    let categorie: Category
    let height : CGFloat
     var showRemoveAlert : () -> Void
    var showEditCat : () -> Void
    @State var isHover = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                KFImage(URL(string: categorie.imageUrl))
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.9)
                    .resizable()
                    .scaledToFill()
                          
                    .frame(width: height,height: height)
                    .cornerRadius(5)
                    .clipped()
                
                Text(categorie.name)
                    .font(.title2)
                Spacer()
                
                if isHover{
                    HStack(spacing: 15){
                        Button{
                            showEditCat()
                        }label: {
                           Image(systemName: "square.and.pencil")
                                .font(.title)
                                
                        }.buttonStyle(.plain)
                            .help("Kategorie Bearbeiten")
                        Button(role: .destructive){
                            showRemoveAlert()
                        }label: {
                            Image(systemName: "trash")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                
                        }.buttonStyle(.plain)
                            .help("Kategorie Löschen")
                    }
                }
               
            }
           
        }.padding(5)
            .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
        .padding(.horizontal,10)
        .onHover { ishover in
            self.isHover = ishover
        }
        
        
    }
}

struct CategorieRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieRowView(categorie: .init(mainId: "",name: "Bier", desc: "sdvsdvs", type: "Main",imageUrl: ""),height: 60,showRemoveAlert: {}) {
            
        }
    }
}
