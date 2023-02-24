//
//  ContentView.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 22.02.23.
//

import SwiftUI

struct ContentView: View {
    @State var results = [LowestPriceEntry]()
    
    var body: some View {
        VStack(alignment: .center) {
            Text("საუკეთესო ფასები")
                .font(.headline)
            List(results, id: \.id) { item in
                LowestPriceView(item: item)
            }.onAppear(perform: loadLowestPriceData)
        }
    }
    
    func loadLowestPriceData() {
        guard let url = URL(string: "http://\(Config.APIBaseUrl)/api/lowest/") else {
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
