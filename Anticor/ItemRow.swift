//
//  ItemRow.swift
//  iDine
//
//  Created by Paul Hudson on 08/02/2021.
//

import SwiftUI

struct ItemRow: View {

    let item: MenuItem

    var body: some View {
        VStack {
            HStack {
                Image(item.image)
                  .resizable()
                  .frame(width: 100, height: 100, alignment: .center)
                  .clipShape(Rectangle())
                  .background(
                      Rectangle()
                      .fill(Color.white)
                      .frame(width: 100, height: 100, alignment: .center)
                  )
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.black)
                   
                }

                Spacer()

            
            }.padding(.horizontal)
            HStack {

                Text("")

            }
            .frame(width: UIScreen.main.bounds.width, height: 1)
            .background(Color.gray.opacity(0.2))

        }.background(Color.white)
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
