//
//  LowestPriceView.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 23.02.23.
//

import SwiftUI

struct LowestPriceView: View {
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
        LowestPriceView(item: test_lowest_price)
            .previewLayout(.sizeThatFits)
    }
}
