//
//  ContentView.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 22.02.23.
//

import SwiftUI

struct ContentView: View {
    @State var results = [LowestPriceEntry]()
    let base_api_url = "192.168.0.200:8000"

    var body: some View {
        NavigationView {
            VStack {
                List(results, id: \.id) { item in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(String(format: "%.2f  ", item.price))
                                .foregroundColor(Color("AccentColor")).bold() +
                            Text(item.fuel_type)
                            Spacer()
                            ForEach(item.providers, id: \.self) { provider in
                                HStack {
                                    Image("\(provider.lowercased())_logo")
                                        .resizable()
                                        .frame(width: 27, height: 27)
                                        .padding(.leading, 5)
                                }
                            }
                            
                            
                        }
                    }
                }.onAppear(perform: loadLowestPriceData)
                    .navigationTitle("მთავარი")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }


    func loadLowestPriceData() {
        guard let url = URL(string:
            "http://\(base_api_url)/api/lowest/") else {
            print("Lowest price API endpoint is Invalid")
            return
        }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([LowestPriceEntry].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
