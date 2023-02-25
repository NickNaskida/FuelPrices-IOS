//
//  HomeView.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 25.02.23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical) {
            Text("საუკეთესო ფასები")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.vertical)
            LowestPriceView()
            Text("ყველა ფასი")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                CurrentPriceView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
