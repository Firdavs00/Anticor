//
//  OrderView.swift
//  iDine
//
//  Created by Paul Hudson on 08/02/2021.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order

    var body: some View {
        NavigationView {
            List {
              
                Section {
                    NavigationLink(destination: SettingsView()) {
                        Text("Часто задаваемые вапросы")
                    }
                }
                //.disabled(order.items.isEmpty)
            }
            .navigationTitle("Hастройки")
            .listStyle(InsetGroupedListStyle())
//            .toolbar {
//                EditButton()
//            }
        }
    }

    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
