//
//  WordExampleSentencesView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/11.
//

import SwiftUI

struct WordExampleSentencesView: View {
    @State var wordContent:String = "aback"
    @State var wordExampleSentences:String = "That's an interesting idea,  I said, taken aback and trying to hide it.<br>您这观点倒挺有意思，我试图掩饰自己的惊讶。<br>She was also taken aback by his intense jealousy and the imbalance between his tight penny-pinching and extravagant spending.<br>她也感到吃惊，他强烈的嫉妒和不平衡之间的紧张节俭和奢侈消费。<br>At last, however, she fell right into the wind's eye, was taken dead aback, and stood there a while helpless, with her sails shivering.<br>可是，最终它却转向风吹来的方向，转过船头处于逆风状态，无助地停泊在那儿，船帆不住地颤抖。<br>I was a little taken aback at how much the Shanghainese staff failed to know about the art of cicada maintenance.<br>身为上海人的员工们竟然不懂得养知了的艺术，这让我多少有些惊讶。<br>Lombard was a good deal taken aback, but in his surprise he did not forget that this was the young lady who had refused him that afternoon.<br>伦巴第先生被吓了一跳，但他吃惊得发现自己还记着今天下午她拒绝了他。<br>She barely knows him, so when he gave her that lovely purse, she was really taken aback.<br>她跟他一点儿都不熟，所以当他送给她那个好看的皮夹时，她非常吃惊。<br>The singer was taken aback by the pirated editions of his songs on the market, and he vowed not to let the thiefs off.<br>Although the guy knew of her feelings for him, he was still taken aback and had never expected her to react that way.<br>尽管小伙子知道她对自己的感情，他还是大吃一惊，完全没有想到她会那样｡<br>If I'm honest, I'm a little taken aback how you all but ignore me for two years then email me only when you need something.<br>坦白说，两年来你直接忽视我，现在有需要才主动联系的行为让我有点讶异。<br>She must have been a little too taken aback to reply as I can't seem to recall what she had to say to that.<br>她一定是花了很长时间才反应过来怎样回答我，因为我记不起她当时是怎么说的了。<br>"
    var maxLine = 3
    
    
    
    func countSentences(str:String) -> Int {
        var sentenceList = str.components(separatedBy: "<br>")
        sentenceList.removeLast()
        if sentenceList.count/2 < self.maxLine {
            return sentenceList.count/2
        }else
        {
            return self.maxLine
        }
        //return sentenceList.count/2
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
        VStack(alignment:.leading) {
            ForEach(0..<self.countSentences(str: self.wordExampleSentences)){
                        num in
                        VStack(alignment:.leading,spacing:5) {
                                HStack(alignment:.top) {
                                    VStack {
                                        Text("\(num+1).")
                                            .fontWeight(.semibold)
                                            .padding(3)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 2.0)
                                                    .stroke())
                                    }.foregroundColor(Color("WordSentencesColor"))
                                    .offset(x: 0, y: 5)
                                    HighlightPartlyView(fullString: self.dealExampleSentences_EN(str: self.wordExampleSentences)[num], wordContent: self.wordContent)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
//                            ZStack {
//                                TextEditor(text:.constant("\(self.dealExampleSentences_CH(str: self.wordExampleSentences)[num])"))
//                                        .font(.callout)
//                                        .padding(.leading,30)
//                                    .foregroundColor(Color("WordSentencesColor"))
                                    //.fixedSize(horizontal: false, vertical: true)
                                Text("\(self.dealExampleSentences_CH(str: self.wordExampleSentences)[num])")
                                    //.opacity(0)
                                    .font(.callout)
                                    .padding(.leading,30)
                                .foregroundColor(Color("WordSentencesColor"))
//                            }
                                Divider()
                            }
                        
                    }.font(.callout)
        }
//        .onTapGesture(perform: {
//            self.hideKeyboard()
//        })

    }
}


struct WordExampleSentencesView_Previews: PreviewProvider {
    static var previews: some View {
        WordExampleSentencesView()
    }
}
