//
//  ContentView.swift
//  iDine
//
//  Created by Paul Hudson on 08/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State var active = false
    @State var action = false
    var user = UserDefault()
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                ScrollView {
                    
                    if !action && !user.getTapButton() {
                        Button(action: {
                            active = true
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Авторизация")
                                    .font(.system(size: 20))
                                Spacer()
                            }
                            
                        }) .frame(height:35)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(5)
                            .padding(.horizontal,20)
                            .padding(.top,5)
                        
                    } else {
                        Button(action: {
                            active = true
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Авторизация")
                                    .font(.system(size: 20))
                                
                                Spacer()
                            }
                        })
                            .frame(height:35)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(5)
                            .padding(.horizontal,20)
                            .padding(.top,5)
                            .hidden()
                        
                    }
                    ForEach(menu) { section in
                        
                        Section(header: Text(section.name)) {
                            ForEach(section.items) { item in
                                NavigationLink(destination: ItemDetail(item: item)) {
                                    ItemRow(item: item)
                                    
                                }
                            }
                        }
                    }
                }
                .padding(.top,5)
            }
            .background(Color.gray.opacity(0.2))
            .navigationTitle("ОБРАЩЕНИЕ")
            .listStyle(GroupedListStyle())
        }
        .sheet(isPresented: $active) {
        } content: {
            
            WebViewOpen(url: URL(string: "http://sso.egov.uz:8443/sso/oauth/Authorization.do?response_type=one_code&client_id=anticorruption.uz&redirect_uri=https://eanticor.uz/uz/api/login-one/&scope=anticorruption.uz&state=0wOQhto6c0bDKLrl28i96w==")!,
                        isComplate: { value in
                
                action = value
                user.tapButton(button: value)
                if value {
                    self.active = false
                    
                } else {
                    print("CAN NOT COMPLATE WEB ACTION")
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



