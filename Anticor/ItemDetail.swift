//
//  ItemDetail.swift
//  iDine
//
//  Created by Paul Hudson on 08/02/2021.
//

import SwiftUI
import AlertToast
/// <#Description#>
struct ItemDetail: View {
    @EnvironmentObject var order: Order
    @StateObject var  organizeVM = ViewModel()
    @State private var showToast = false
    let item: MenuItem
    
    enum SumType: String, CaseIterable, Identifiable {
        case Сум
        case Доллар
        
        var id: String { self.rawValue }
    }
    
    @State var amount: String = ""
    @State var text: String = ""
    
    @State var sumType: SumType = .Сум
//    var fruits = ["Я столкнулся с взяточничеством и дал взятку", "Я столкнулся с взяточничеством, но не дал взятку. Я против коррупции", "Я столкнулся с видом коррупции не связенной с взяточничеством", "Я встретил честного сотрудника государственного органа" ]
    @State private var selectedIndex = 0
    @State var isSheet = false
    @State var regionName: String = ""
    @State var districtName: String = ""
    @State var organName: String = ""
    @State var comment: String = ""
    @State var regionId: Int = 0
    @State var districtId: Int = 0
    @State var organId: Int = 0
    @State var commentId: Int = 0
    // <#Description#>
    var body: some View {
        
        
       
            VStack {
                Form(content: {
                    
                    VStack (alignment: .leading){
                        
                        Button(action: {
                            isSheet.toggle()
                        }) {
                            Text("Город")
                        }.sheet(isPresented: $isSheet, content: {
                            ItemSheet(prodName: $regionName, prodId: $regionId, ifFrom: .city)
                                .environmentObject(organizeVM)
                        })
                        
                        Text(regionName).padding(.top,3)
                    }
                    
                    VStack (alignment: .leading) {
                        Button(action: {
                            isSheet.toggle()
                        }) {
                            Text("Область")
                        }.sheet(isPresented: $isSheet, content: {
                            ItemSheet( prodName: $districtName, prodId: $districtId, ifFrom: .region)
                                .environmentObject(organizeVM)

                        })
                        Text(districtName).padding(.top,3)
                    }
                    
                    VStack (alignment: .leading) {
                        Button(action: {
                            isSheet.toggle()
                        }) {
                            Text("Организация")
                        }.sheet(isPresented: $isSheet, content: {
                            ItemSheet(prodName: $organName, prodId: $organId, ifFrom: .organization)
                                .environmentObject(organizeVM)

                        })
                        Text(organName).padding(.top,3)
                    }
                    
                    Section(header: Text("")) {
                        // Segment Picker
                        Picker("SumType", selection: $sumType) {
                            ForEach(SumType.allCases) { gender in
                                Text(gender.rawValue.capitalized).tag(gender)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    VStack (alignment: .leading) {
                        Button(action: {
                            isSheet.toggle()
                        }) {
                            Text("leaveComment")
                        }.sheet(isPresented: $isSheet, content: {
                            ItemSheet( prodName: $comment, prodId: $commentId, ifFrom: .button_Type)
                        })
                        Text(comment).padding(.top,3)
                    }
                    
                    Section(header: Text("")) {
                        // Text field
                        TextField("Размер взятки (сумма)", text: $organizeVM.summ)
                            .onChange(of: organizeVM.showSheet, perform: { value in
                                if value {
                                    self.organizeVM.summ = ""
                                }
                            })
                       
                    }
                    Section(header: Text("")) {
                        // Secure field
                        VStack (alignment: .leading){
                            Text("Текст заявления").foregroundColor(.blue)
                        ZStack {
                  
                                TextEditor(text: $organizeVM.zayavleni )
                                .onChange(of: organizeVM.showSheet, perform: { value in
                                    if value {
                                        self.organizeVM.zayavleni = ""
                                    }
                                })
                            
                            Text(organizeVM.zayavleni).opacity(0).padding(.all, 8)
                        }
                        .shadow( radius: 1)
                        }
                    }
                 
                    // Button
                    Button(action: {
                        organizeVM.sendData(cityId: regionId, oblastId: districtId, organId: organId, summ: Int(organizeVM.summ) ?? 0, commentId: commentId, text: organizeVM.zayavleni)
                    }) {
                        HStack {
                            Spacer()
                            Text("Отправить")
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.accentColor)
                    .cornerRadius(8)
                })
            }
        .toast(isPresenting: $showToast, duration: 1.5, tapToDismiss: false, alert: {
            AlertToast(
                type: .complete(.green),
                title: "Успешно")
        })
        .onChange(of: organizeVM.showSheet, perform: { value in
            showToast = value
        })
        .navigationBarTitle("Подать заявку")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example)
                .environmentObject(Order())
        }
    }
}


