//
//  ContentView.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 22.02.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                ScrollView(.vertical) {
                    Text("საუკეთესო ფასები")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    LowestPriceView().padding(.horizontal)
                    Text("ყველა ფასი")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    ScrollView(.horizontal, showsIndicators: false) {
                        CurrentPriceView()
                    }
                }.navigationTitle(Text("მთავარი"))
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}
