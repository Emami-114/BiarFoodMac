//
//  ToastExtension.swift
//  BiarFoodMac
//
//  Created by Ecc on 06/09/2023.
//

import SwiftUI

struct ToastExtension: ViewModifier {
    @Binding var isShowing: Bool
    let duration : TimeInterval
    let text: String
    func body(content: Content) -> some View {
        ZStack{
            content
            if isShowing{
                VStack{
                    Spacer()
                    HStack(spacing: 10){
                        Image(systemName: "checkmark.circle")
                            .font(.title2)
                        Text(text)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .frame(minWidth: 0,maxWidth: 250)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    
                }
                .padding()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                        withAnimation(.spring()) {
                            isShowing = false
                        }
                    }
                }
            }
        }
    }
}
extension View {
    func toast(isShowing: Binding<Bool>,duration: TimeInterval = 2,text: String = "Erfolgreich erstellt.") -> some View {
        modifier(ToastExtension(isShowing: isShowing, duration: duration, text: text))
    }
}


