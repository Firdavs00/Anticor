//
//  SettingsView.swift
//  iDine
//
//  Created by Apple Bro on 05/12/21.
//

import SwiftUI

struct FAQ {
    var question: String
    var answers: [String]
}


struct SettingsView: View {
    
    let information: [FAQ] = [
            FAQ(question: "•  Что такое Коррупция?", answers: ["коррупция - это незаконное использование лица с целью получения материальных или нематериальных выгод от его карьеры или службы или интересов других лиц, а также незаконное предоставление таких выгод. Источник: закон Республики Узбекистан О борьбе с коррупцией"]),
            
            FAQ(question: "•  Что включает в себя коррупционные правонарушения?", answers: ["коррупция аломатларига эга бўлган, содир этилганлиги учун қонун ҳужжатларида жавобгарлик назарда тутилган қилмиш коррупцияга оид ҳуқуқбузарлик ҳисобланади. Манба: Ўзбекистон Республикасининг “Коррупцияга қарши курашиш тўғрисида”ги Қонуни"]),
            
            FAQ(question: "•  Что входит в состав правонарушений, связанных с коррупцией?", answers: ["имея признаки коррупции, Деяние, предусматривающее ответственность в законодательстве за его совершение, считается нарушением коррупционного характера."]),
            
            FAQ(question: "•  Как должен вести себя государственный служащий при возникновении конфликта интересов?", answers: ["государственные служащие обязаны информировать своего руководителя либо правоохранительные органы обо всех случаях обращений каких-либо лиц с целью склонения их к совершению правонарушений, а также о любых известных им случаях правонарушений, совершенных другими государственными служащими. Источник: постановление Кабинета Министров от 2 марта 2016 г. № 62"]),
           
        ]

        var body: some View {
            List {
                ForEach(information, id: \.question) { info in
                    InfoSection(info: info)
                }
            }
                .navigationTitle("Вопросы")
                .listStyle(InsetGroupedListStyle())
        }
    }

struct InfoSection: View {

    let info: FAQ
    @State var showsAnswer = false

    var body: some View {
        Section(header: questionHeader) {
            if showsAnswer {
                ForEach(info.answers, id: \.self) { answer in
                    Text(answer)
                }
            }
        }
    }

    var questionHeader: some View {
        Text(info.question)
            .foregroundColor(.primary)
            .onTapGesture {
            self.showsAnswer.toggle()
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
