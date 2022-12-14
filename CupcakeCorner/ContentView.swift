//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by 최준영 on 2022/12/06.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Cake type", selection: $order.publishedData.type) {
                        ForEach(Order.types.indices) { index in
                            Text(Order.types[index])
                        }
                    }
                    Stepper("Number of cakes: \(order.publishedData.quantity)", value: $order.publishedData.quantity, in: 3...20)
                }

                Section {
                    Toggle("Any special requests?", isOn: $order.publishedData.specialRequestEnabled.animation())

                    if order.publishedData.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.publishedData.extraFrosting)

                        Toggle("Add extra sprinkles", isOn: $order.publishedData.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
