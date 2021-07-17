//
//  Thanks.swift
//  FirebaseDemo
//
//  Created by Luis Calmon on 15/7/21.
//

import SwiftUI

struct Thanks: View {
    
    @EnvironmentObject var storeManager: StoreManager
    
    var body: some View {
        if let product = storeManager.myProducts.first {
            VStack {
                if UserDefaults.standard.bool(forKey: product.productIdentifier) {
                    Image(systemName: "hands.sparkles.fill")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .scaleEffect(0.5)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                } else {
                    Button(action: {storeManager.purchaseProduct(product: product)}) {
                        Image(systemName: "figure.wave.circle")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .scaleEffect(0.5)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    Text(product.localizedPrice)
                        .font(.headline)
                }
                Text(product.localizedTitle)
                    .font(.headline)
                Text(product.localizedDescription)
                    .font(.caption2)
            }
        }
    }
}

struct Thanks_Previews: PreviewProvider {
    static var previews: some View {
        Thanks()
            .environmentObject(StoreManager())
    }
}
