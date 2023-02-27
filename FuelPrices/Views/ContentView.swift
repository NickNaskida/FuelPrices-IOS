//
//  ContentView.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 22.02.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            
            TabView {
                HomeView().tabItem {
                    Image(systemName: "house")
                    Text("მთავარი")
                }
                CompareView().tabItem {
                    Image(systemName: "arrow.right.arrow.left.square")
                    Text("შედარება")
                }
            }.dynamicTypeSize(.medium ... .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}
