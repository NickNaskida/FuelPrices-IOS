//
//  LowestPriceView.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 23.02.23.
//

import SwiftUI

struct LowestPriceView: View {
    @State var results = [LowestPriceEntry]()
    
    var body: some View {
        LazyVStack {
            ForEach(results, id: \.id) { item in
                LowestPriceRow(item: item)
            }
        }.padding(15)
            .background(Color("CardColor"))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("BorderColor"), lineWidth: 2)
            )
            .cornerRadius(15)
            .onAppear(perform: loadLowestPriceData)
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

struct LowestPriceRow: View {
    let item: LowestPriceEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(String(format: "%.2f  ", item.price))
                    .foregroundColor(Color("AccentColor")).bold() +
                Text(item.fuel_type)
                Spacer()
                ForEach(item.providers.reversed(), id: \.self) { provider in
                    HStack {
                        Image("\(provider.lowercased())_logo")
                            .resizable()
                            .frame(width: 27, height: 27)
                            .padding(.leading, 5)
                    }
                }
            }
        }
    }
}

struct LowestPriceView_Previews: PreviewProvider {
    static var previews: some View {
        LowestPriceView()
            .previewLayout(.sizeThatFits)
    }
}
