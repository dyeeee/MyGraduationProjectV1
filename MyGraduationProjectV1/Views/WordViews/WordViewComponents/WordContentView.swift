//
//  wordContentView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/10.
//

import SwiftUI

struct WordContentView: View {
    @State var wordContent:String = "allow"
    
    var body: some View {
        VStack {
            Text(self.wordContent )
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.clear)
                .overlay(Rectangle().frame(height:4)
                            .foregroundColor(Color.blue.opacity(0.8))
                            .offset(x:0,y:12))
        }.overlay(
            Text(self.wordContent )
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
        )
        
    }
}

struct wordContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordContentView()
    }
}
