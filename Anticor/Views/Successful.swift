//
//  Successful.swift
//  iDine
//
//  Created by Firdavs Boltayev on 12/12/21.
//

import SwiftUI

struct Successful: View {
    
    @State var isSheet = false
    var body: some View {
        
        
        VStack (spacing: 30) {
            if !isSheet {
            HStack (spacing:3) {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                
                Text("Успешно!")
                    .foregroundColor(.white)
                    .font(.system(size: 20))

            }
            .frame(width: 140, height: 40)
            .background(Color.green)
            .cornerRadius(20)
            .hidden()
            } else {
               
                HStack (spacing:3) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    
                    Text("Успешно!")
                        .foregroundColor(.white)
                        .font(.system(size: 20))

                }
                .frame(width: 140, height: 40)
                .background(Color.green)
                .cornerRadius(20)
            }
            
            
            Button(action: {
                
                isSheet = true
            }, label: {
                Text("tapButton")
            })
        }
        
    }
}

struct Successful_Previews: PreviewProvider {
    static var previews: some View {
        Successful()
    }
}
