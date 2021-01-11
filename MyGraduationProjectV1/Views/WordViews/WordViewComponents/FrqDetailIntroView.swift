//
//  FrqDetailIntroView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/10.
//

import SwiftUI

struct FrqDetailIntroView: View {
    var body: some View {
        NavigationView {
            VStack(spacing:20) {
                VStack(alignment:.leading,spacing:10) {
                    Text("OXFORD 牛津3000核心词汇")
                        .font(.title3)
                    Text("牛津3000核心词汇是一份从包含20亿词的牛津英语语料库（Oxford English Corpus）中精选而出的英语学习者必备常用 3000+ 词汇")
                        
                }.padding(10)
                
                
            }.navigationTitle("单词标签介绍")
            .padding()
        }
    }
}

struct FrqDetailIntroView_Previews: PreviewProvider {
    static var previews: some View {
        FrqDetailIntroView()
    }
}
