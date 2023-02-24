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
