//
//  MainView.swift
//  iDine
//
//  Created by Paul Hudson on 08/02/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Главная", systemImage: "house")
                    }

                WebView(type: .public, url: "https://eanticor.uz/ru/")
                    .tabItem {
                        Label("Статистика", systemImage: "fiberchannel")
                    }
                
                OrderView()
                    .tabItem {
                        Label("Hастройки", systemImage: "gear")
                    }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Order())
    }
}
