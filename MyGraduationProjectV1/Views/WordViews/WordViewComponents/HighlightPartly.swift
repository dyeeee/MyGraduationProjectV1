//
//  HighlightPartly.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/11.
//

import SwiftUI

struct HighlightPartlyView: View {
    @State var fullString: String = "Excuse me what eyedrop can be treated or to what eyedrop can be treated or alleviate myopic eyedrop ah?"
    @State var wordContent:String = "alleviate"
    
    var body: some View{
        //let testo : String = "There is a thunderstorm in the area"
        let stringArray = self.fullString.components(separatedBy: " ")
        let stringToTextView = stringArray.reduce(Text(""), {
            if $1 == self.wordContent {
                return $0 + Text($1)
                                .bold()
                    .foregroundColor(Color(.systemBlue))
                        + Text(" ")
            } else {
                return $0 + Text($1) + Text(" ")
            }
            
        })
        return stringToTextView
    }
}





struct HighlightPartly_Previews: PreviewProvider {
    static var previews: some View {
        HighlightPartlyView()
    }
}
