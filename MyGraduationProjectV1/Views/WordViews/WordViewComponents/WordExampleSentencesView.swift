//
//  WordExampleSentencesView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/11.
//

import SwiftUI

struct WordExampleSentencesView: View {
    @State var wordContent:String = "alleviate"
    @State var wordExampleSentences:String = "Excuse me what eyedrop can be treated or to what eyedrop can be treated or alleviate myopic eyedrop ah?<br>请问一下有没有什么眼药水可以治疗或缓解近视的眼药水啊？<br>And ease the tension in the form of many, why not bring serious harm to the body of a factor to alleviate it?<br>而且缓解紧张情绪的形式很多，为什么非要拿一个严重危害身体的因素来缓解呢？<br>The reason that cats can alleviate negative moods is often attributed to attachment - the emotional bond between cat and owner.<br>猫能够改善人们负性情绪的原因往往都归于他们对人的依恋——猫与主人间的感情粘合剂。<br>'We'd like to see if diet after birth could alleviate this problem that was programmed before birth, ' he said.<br>“我们希望能看见出生后饮食方式的改变可以减轻这些出生前引起的问题，”他说。<br>Use in the database compress a technology, it is to solve (perhaps alleviate at least) place of this kind of pressure one of made effort.<br>在数据库中使用压缩技术，是为了解决（或者至少缓解）这种压力所做出的努力之一。<br>And if scientists can unravel what underlies these biological differences, they might be able to alleviate inborn disparities.<br>如果科学家们能够解决造成这种生物学差异的原因，也许就能缓解人们的先天差距。<br>North Korea said on Monday that it was ready to discuss humanitarian aid from the South to alleviate damage caused by flooding and typhoons.<br>周一，朝鲜表示已准备好就从韩国获取人道主义援助进行商讨，以缓解洪灾和台风造成的损失。<br>Goldman Sachs said the moves 'should help to . . . alleviate market stresses, but are incremental rather than transformational' .<br>高盛（GoldmanSachs）表示：“此举应有助于……减轻市场压力，但是是一种量变而非质变。”<br>Jesus' hunger, she said, is what 'you and I must find' and alleviate.<br>她说，“耶稣的饥渴，是你我必须要寻求且予以帮助的。”<br>One of the nurses asked if I would like some ice chips to help alleviate problem.<br>一位护士问我要不要含一些碎冰块来缓解一下。<br>"
    
    func countSentences(str:String) -> Int {
        var sentenceList = str.components(separatedBy: "<br>")
        sentenceList.removeLast()
        return sentenceList.count/2
    }
    
    //    func dealExampleSentences_EN(str:String,currentWord:String) -> [[String]] {
    //        var sentenceList = str.components(separatedBy: "<br>")
    //        sentenceList.removeLast()
    //        var i = 0
    //        var sentenceList_EN:[String] = []
    //
    //        while i<sentenceList.count {
    //            if (i % 2 == 0) {
    //                sentenceList_EN.append(sentenceList[i])
    //            }
    //            i = i + 1
    //        }
    //
    //        var sentenceListList_EN:[[String]] = []
    //        for sentence in sentenceList_EN {
    //            sentenceListList_EN.append(sentence.components(separatedBy: currentWord))
    //        }
    //
    //        return sentenceListList_EN
    //    }
    
    func dealExampleSentences_EN(str:String) -> [String] {
        let sentenceList = str.components(separatedBy: "<br>")
        var i = 0
        var sentenceList_EN:[String] = []
        
        while i<sentenceList.count {
            if (i % 2 == 0) {
                sentenceList_EN.append(sentenceList[i])
            }
            i = i + 1
        }
        return sentenceList_EN
    }
    
    func dealExampleSentences_CH(str:String) -> [String] {
        let sentenceList = str.components(separatedBy: "<br>")
        var i = 0
        var sentenceList_CH:[String] = []
        
        while i<sentenceList.count {
            if (i % 2 != 0) {
                sentenceList_CH.append(sentenceList[i])
            }
            i = i + 1
        }
        return sentenceList_CH
    }
    
    
    var body: some View {
            List {
                    ForEach(0..<3){
                        num in
                        HStack {
                            VStack {
                                Text("\(num+1).")
                                    .fontWeight(.semibold)
                                    .padding(3)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2.0)
                                            .stroke())
                            }.foregroundColor(Color("WordLevelsColor"))
                            
                            
                            VStack(alignment:.leading) {
                                HighlightPartlyView(fullString: self.dealExampleSentences_EN(str: self.wordExampleSentences)[num], wordContent: self.wordContent)
                                Text("\(self.dealExampleSentences_CH(str: self.wordExampleSentences)[num])")
                                    .font(.caption)
                            }
                        }
                        
                        
                    }.font(.callout)
            }
            .frame(width:.infinity,height:200)
            .padding(0)

    }
}

struct WordExampleSentencesView_Previews: PreviewProvider {
    static var previews: some View {
        WordExampleSentencesView()
    }
}
