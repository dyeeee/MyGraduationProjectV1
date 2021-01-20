//
//  LearnWordList.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//

import SwiftUI

struct LearnWordList: View {
//    @ObservedObject var learningViewModel: LearningViewModel = LearningViewModel()
    
    var body: some View {
        List{
            Section(header: Text("全部单词")) {
//                ForEach(self.learningViewModel.itemList, id:\.self){
//                    item in
                    VStack(alignment:.leading){
                        //Text(item.wordID)
                        Text("test")
                    }
//                }
            }
        }
    }
}

struct LearnWordList_Previews: PreviewProvider {
    static var previews: some View {
        LearnWordList()
    }
}
