//
//  Utils.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 13.03.23.
//

import Foundation


extension FuelTypeParam {
    
    convenience init(fuelType: FuelTypeEntry) {
        self.init(identifier: fuelType.id, display: fuelType.name)
        self.typeAlt = fuelType.type_alt
    }
    
}
