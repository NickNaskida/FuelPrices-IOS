//
//  CompareView.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 27.02.23.
//

import SwiftUI
import Charts

struct CompareView: View {
    @State var fuelPrices = [CompareEntry]()
    @State var fuelTypes = [FuelTypeEntry]()
    @State var isLoading = true
    @State private var selectedFuelType = "diesel"
    
    var body: some View {
        ScrollView(.vertical) {
            Text("შედარება")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.vertical)
            
            if isLoading {
                VStack(alignment: .center) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("AccentColor")))
                }.frame(height: 200)
                    .padding(.vertical)
            } else {
                Chart {
                    ForEach(fuelPrices) { fuel_price in
                        BarMark(
                            x: .value("ფასი", fuel_price.price),
                            y: .value("პროვაიდერი", fuel_price.provider)
                        ).cornerRadius(7)
                            .annotation(position: .overlay, alignment: .trailing) {
                                Text(String(format: "%.2f ₾ ", fuel_price.price))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                            }
                    }
                }.padding(.horizontal)
                    .frame(height: 350)
            }
            
            Picker("აირჩიეთ საწვავი ტიპი", selection: $selectedFuelType) {
                ForEach(fuelTypes, id: \.self) { item in
                    Text(item.name).tag(item.type_alt)
                }
            }.pickerStyle(.inline)
                .onChange(of: selectedFuelType) { fuelType in
                    loadFuelPrices()
                }
        }.onAppear{
            loadFuelTypes()
            loadFuelPrices()
        }
    }
    
    func loadFuelTypes() {
        guard let url = URL(string: "\(Config.APIBaseUrl)/utils/fuel-types") else {
            print("Fuel type API endpoint is Invalid")
            return
        }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([FuelTypeEntry].self, from: data) {
                    DispatchQueue.main.async {
                        self.fuelTypes = response
                    }
                    return
                }
            }
        }.resume()
    }
    
    func loadFuelPrices() {
        guard let url = URL(string: "\(Config.APIBaseUrl)/compare/\(selectedFuelType)") else {
            print("Fuel compare price API endpoint is Invalid")
            return
        }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([CompareEntry].self, from: data) {
                    DispatchQueue.main.async {
                        self.fuelPrices = response
                        isLoading = false
                    }
                    return
                }
            }
        }.resume()
    }
}

struct CompareView_Previews: PreviewProvider {
    static var previews: some View {
        CompareView()
    }
}
