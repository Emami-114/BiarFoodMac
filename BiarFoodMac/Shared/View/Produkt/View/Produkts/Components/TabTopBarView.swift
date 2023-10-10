//
//  TabTopBarView.swift
//  BiarFoodMac
//
//  Created by Ecc on 28/09/2023.
//

import SwiftUI

struct TabTopBarView: View {
    @EnvironmentObject var viewModel : ProductListViewModel
    @Namespace var nameSpace
    var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader(content: { proxy in
                LazyHStack(spacing: 15){
                    ForEach(viewModel.categories,id: \.id){category in
                        TabTopitem(currenItem: $viewModel.selectedCategory, tabItem: category, namenSpace: nameSpace, action: {
                            DispatchQueue.main.async {
                                viewModel.products = []
                                viewModel.fetchProducts(with: category.id ?? "")
                            }
                           
                        })
                        
                    }
                }
                .onChange(of: viewModel.selectedCategory) { oldValue, newValue in
                    withAnimation(.easeInOut(duration: 0.5)){
                        proxy.scrollTo(newValue,anchor: .center)
                    }
                }
            })
        }
    }
}




struct TabTopitem: View {
    @Binding var  currenItem: String
    let tabItem: Category
    var namenSpace : Namespace.ID
    var action: () -> Void
    
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)){
                currenItem = tabItem.id ?? ""
                action()
            }
        } label: {
            Text(tabItem.name)
                .font(.headline)
                .foregroundStyle(currenItem == tabItem.id ?? "" ? .white : .white)
                .padding(.horizontal,10)
                .frame(minWidth: 100)
                .frame(maxHeight: 35)
                .background(.white.opacity(0.0001))
        }
        .background {
            if currenItem == tabItem.id ?? "" {
                RoundedRectangle(cornerRadius: 10).fill(Color.primary.opacity(0.4))
                    .matchedGeometryEffect(id: "TOPTABBAR", in: namenSpace)
            }else {
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5).fill(Color.primary.opacity(0.7))
            }
        }
        .buttonStyle(PlainButtonStyle())
        
    }
}

#Preview {
    TabTopitem(currenItem: .constant("Bier"), tabItem: .init(id: "Bier2",mainId: "", name: "Bier", desc: "", type: "Main", imageUrl: ""), namenSpace: Namespace().wrappedValue, action: {})
        .frame(width: 400,height: 400)
}

#Preview {
    Group{
        TabTopBarView()
            .environmentObject(ProductListViewModel())
    }
}
