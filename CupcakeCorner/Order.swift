//
//  Order.swift
//  CupcakeCorner
//
//  Created by 최준영 on 2022/12/07.
//

import SwiftUI

class Order: ObservableObject, Codable {
    struct PublishedData: Codable {
        // ContentView
        var type = 0
        var quantity = 3
        var extraFrosting = false
        var addSprinkles = false
        var specialRequestEnabled = false {
            didSet {
                if !specialRequestEnabled {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var cost: Double {
            // $2 per cake
            var cost = Double(quantity) * 2
            // complicated cakes cost more
            cost += (Double(type) / 2)
            // $1/cake for extra frosting
            if extraFrosting {
                cost += Double(quantity)
            }
            // $0.50/cake for sprinkles
            if addSprinkles {
                cost += Double(quantity) / 2
            }
            return cost
        }
        // AddressView
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        var isValidAdress: Bool {
            !name.trimmingCharacters(in: [" "]).isEmpty &&
            !streetAddress.trimmingCharacters(in: [" "]).isEmpty &&
            !city.trimmingCharacters(in: [" "]).isEmpty
            && !zip.trimmingCharacters(in: [" "]).isEmpty
        }
    }
    // CodingKey way
    enum CodingKeys: CodingKey {
        case publishedData
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var publishedData = PublishedData()
    
    // conformance for Decodable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let _ = try container.decode(PublishedData.self, forKey: .publishedData)
    }
    //for initailizing in ContentView, previews
    init() { }
    // conformance for Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(publishedData, forKey: .publishedData)
    }
}

