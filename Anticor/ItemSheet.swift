//
//  ItemSheet.swift
//  iDine
//
//  Created by Firdavs Boltayev on 10/12/21.
//

import SwiftUI

struct ItemSheet: View {
    @EnvironmentObject var vm: ViewModel
    @Environment (\.presentationMode) var presentation
    @State var active = false
    @Binding var prodName: String
    @Binding var prodId: Int
    @State var regId = 1
    var ifFrom: viewType
    var fruits = ["Poraxo'rlikka duch keldim va pora berishga majbur bo'ldim", "Poraxo'rlikka duch keldim va pora bermadim", "Pora berishga bog'liq bo'lmagan korrupsiyaga duch keldim", "Halol ishlaydigan davlat xizmatchisini uchratdim"]
    var body: some View {
        
        switch ifFrom {
        case .city:
            city
                .onAppear {
                    vm.parseRegionList()
                }
        case .region:
            district
                .onAppear {
                    vm.parseRegionDetail(id: regId)
                }
        case .organization:
            organ
                .onAppear {
                    vm.parseOrganizationList()
                }
        case .button_Type:
            button_type
        }
    }
}

extension ItemSheet {
    private var city: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack{
                    Rectangle().foregroundColor(.gray.opacity(0.3))
                }.frame(width: UIScreen.main.bounds.width, height: 30)
                
                ForEach(0..<vm.regions.count, id: \.self) { item in
                    HStack {
                        Button(action: {
                            prodName = vm.regions[item].name ?? ""
                            prodId = vm.regions[item].id ?? 0
                            regId = vm.regions[item].id ?? 0
                            presentation.wrappedValue.dismiss()
                            print(prodName)
                            print(regId)
                        }, label: {
                            Text(vm.regions[item].name ?? "").foregroundColor(.black)
                        })
                        Spacer()
                    }.padding(.leading,5)
                    Divider()
                }
            }
        }
    }
    
    private var district: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack{
                    Rectangle().foregroundColor(.gray.opacity(0.3))
                }.frame(width: UIScreen.main.bounds.width, height: 30)
                
                ForEach(0..<vm.areas.count, id: \.self) { item in
                    HStack {
                        Button(action: {
                            prodName = vm.areas[item].name ?? ""
                            prodId = vm.areas[item].id ?? 0
                            presentation.wrappedValue.dismiss()
                            print(prodName)
                            print(prodId)
                        }, label: {
                            Text(vm.areas[item].name ?? "").foregroundColor(.black)
                        })
                        Spacer()
                    }.padding(.leading,5)
                    Divider()
                }
            }
        }
    }
    
    private var organ: some  View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack{
                    Rectangle().foregroundColor(.gray.opacity(0.3))
                }.frame(width: UIScreen.main.bounds.width, height: 30)
                ForEach(0..<vm.organization.count, id: \.self) { item in
                    HStack {
                        Button(action: {
                            prodName = vm.organization[item].name ?? ""
                            prodId = vm.organization[item].id ?? 0
                            presentation.wrappedValue.dismiss()
                            print(prodName)
                            print(prodId)
                        }, label: {
                            Text(vm.organization[item].name ?? "").foregroundColor(.black)
                        })
                        Spacer()
                    }.padding(.leading,5)
                    Divider()
                }
            }
        }
    }
    
    private var button_type: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack{
                    Rectangle().foregroundColor(.gray.opacity(0.3))
                }.frame(width: UIScreen.main.bounds.width, height: 30)
                
                ForEach(0..<fruits.count, id: \.self) { item in
                    HStack {
                        Button(action: {
                            prodName = fruits[item]
                            prodId = item
                            presentation.wrappedValue.dismiss()
                            print("FikrId: \(prodId)")
                            print("Name:\(prodName)")
                        }, label: {
                            Text(fruits[item]).foregroundColor(.black)
                        })
                        Spacer()
                    }.padding(.leading,5)
                    Divider()
                }
            }
        }
    }
    
}

enum viewType {
    case city, region, organization, button_Type
}

