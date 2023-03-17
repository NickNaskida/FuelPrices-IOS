//
//  IntentHandler.swift
//  FuelPricesIntentExtension
//
//  Created by Nikoloz Naskidashvili on 13.03.23.
//

import Intents

class IntentHandler: INExtension { //, SelectFuelTypeIntentHandling {
    
    
//    func provideFuelTypeOptionsCollection(for intent: SelectFuelTypeIntentHandling, with completion:
//        @escaping (INObjectCollection<CountryParam>?, Error?) -> Void) {
//
//
//    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
