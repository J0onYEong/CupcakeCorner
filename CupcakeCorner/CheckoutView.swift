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
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
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
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                .alert("Thank you!", isPresented: $showingConfirmation) {
                    Button("Ok") { }
                } message: {
                    Text(confirmationMessage)
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func placeOrder() async {
        // encoding
        guard let encodedData = try? JSONEncoder().encode(order) else {
            print("encoding Error")
            return;
        }
        // request configuration
        let urlStr = "https://reqres.in/api/cupcakes"
        let url = URL(string: urlStr)!
        var req = URLRequest(url: url)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: req, from: encodedData)
            // decoding, 요청이 성공할 경우 ReqRes.in 사이트는 튜플의 data멤버에 POST한 데이터를 그대로 돌려준다.
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("checkout failed")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
