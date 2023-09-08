//
//  SlidersMainView.swift
//  BiarFoodMac
//
//  Created by Ecc on 07/09/2023.
//

import SwiftUI

struct SlidersMainView: View {
    var body: some View {
        GeometryReader { proxy in

        HSplitView {
                CreateSliderView()
                    .frame(maxWidth: 550)
            SlidersListView(proxy: proxy.size)

            }

           
        }
        
    }
}

struct SlidersMainView_Previews: PreviewProvider {
    static var previews: some View {
        SlidersMainView()
    }
}
