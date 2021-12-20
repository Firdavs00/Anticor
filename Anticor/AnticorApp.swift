//
//  AnticorApp.swift
//  Anticor
//
//  Created by Apple Bro on 14/12/21.
//

import SwiftUI

@main
struct AnticorApp: App {
    @StateObject var order = Order()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
                .onAppear {
                    print(UserDefaults.standard.string(forKey: "token") ?? "")
                    
                }
        }
    }
}
//f19b1ec31cad72e626c86d5ff133c868f045fb4b

