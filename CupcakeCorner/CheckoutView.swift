//
//  CheckOut.swift
//  CupcakeCorner
//
//  Created by 최준영 on 2022/12/08.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var loadingGray: Color {
        Color(red: 236/255, green: 240/255, blue: 241/255)
    }
}

struct CheckoutView: View {
    @ObservedObject var order: Order
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ZStack {
                        Color.loadingGray
                        Text("Image loading...")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
                .frame(height: 233)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order", action: { })
                    .padding()
                
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
