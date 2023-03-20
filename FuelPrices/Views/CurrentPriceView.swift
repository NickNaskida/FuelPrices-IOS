//
//  CurrentPriceView.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 24.02.23.
//

import SwiftUI
import Foundation

struct CurrentPriceView: View {
    @State var current_results = [CurrentPriceEntry]()
    @State var isLoading = true
    
    var body: some View {
        if isLoading {
            VStack(alignment: .center) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("AccentColor")))
            }.frame(width: 390, height: 260)
        }
        
        LazyHStack {
            ForEach(current_results, id: \.id) { item in
                CurrentPriceCard(item: item).cornerRadius(15)
            }
        }.padding(20)
            .onAppear(perform: loadCurrentPriceData)
    }
    
    func loadCurrentPriceData() {
        guard let url = URL(string: "\(Config.APIBaseUrl)/current/") else {
            print("Current price API endpoint is Invalid")
            return
        }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([CurrentPriceEntry].self, from: data) {
                    DispatchQueue.main.async {
                        self.current_results = response
                        isLoading = false
                    }
                    return
                }
            }
        }.resume()
    }
}

struct CurrentPriceCard: View {
    let item: CurrentPriceEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("\(item.provider.lowercased())_logo")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(.vertical, 2)
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    Text(item.provider)
                        .font(.title)
                        .bold()
                    Text(item.last_updated)
                        .font(.subheadline)
                        .foregroundColor(Color(.secondaryLabel))
                }
                Spacer()
                
            }.padding(.vertical, 2)
                .padding(.bottom, 10)
            Spacer()
            VStack {
                ForEach(item.fuel, id: \.self) { fuel in
                    HStack {
                        Text(String(format: "%.2f ₾ ", fuel.price))
                            .foregroundColor(Color("AccentColor")).fontWeight(.bold) + Text(fuel.name)
                        Spacer()
                        if fuel.change_rate != 0 {
                            Text(
                                String(format: "\(fuel.change_rate > 0 ? "↑" : (fuel.change_rate < 0 ? "↓" : "")) %.2f", abs(fuel.change_rate))
                            ).font(.subheadline)
                                .padding(.horizontal, 3)
                                .foregroundColor(
                                    fuel.change_rate > 0 ? Color("BgRed") : Color("BgGreen")
                                )
                                .cornerRadius(4)
                        }
                    }.padding(.bottom, 1)
                }
            }
            Spacer()
        }.frame(width: 310, height: 260)
            .padding(15)
            .background(Color("CardColor"))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("BorderColor"), lineWidth: 2)
            )
    }
}

struct CurrentPriceView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentPriceView()
            .previewLayout(.sizeThatFits)
    }
}
