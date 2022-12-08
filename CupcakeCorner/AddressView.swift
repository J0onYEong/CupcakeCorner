//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by 최준영 on 2022/12/07.
//

import SwiftUI


struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.publishedData.name)
                TextField("Street Address", text: $order.publishedData.streetAddress)
                TextField("City", text: $order.publishedData.city)
                TextField("Zip", text: $order.publishedData.zip)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!order.publishedData.isValidAdress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
