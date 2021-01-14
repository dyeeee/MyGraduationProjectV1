//
//  WordListView.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/24.
//

import SwiftUI


enum WordListType {
    case searchResult
    case notebook
    case all
}

//通用的单词列表界面
struct WordListView: View {
    @ObservedObject var wordListViewModel: WordListViewModel
    @State private var searchText = ""
    @State var dataType: WordListType = .all
    
    func headerText(_ dataType:WordListType) -> String {
        if self.dataType == .searchResult {
            return "Result"
        }else
        {return "test"}
    }
    
    var body: some View {
        //        NavigationView{
        List{
            if(dataType == .searchResult){
                Section{
                    HStack {
                        TextField("Search", text: $searchText)
                            .onChange(of: searchText, perform: { value in
                                self.wordListViewModel.searchItems(begins: self.searchText)
                            })
                        Button(action: {
                            self.wordListViewModel.searchItems(begins: self.searchText)
                        }, label: {
                            Image(systemName:"magnifyingglass")
                        })
                    }
                }
            }
            Section(header: Text("\(headerText(self.dataType))")) {
                ForEach(self.wordListViewModel.getItems(self.dataType),id:\.self){
                    item in
                    NavigationLink(
                        destination: WordDetailView(wordItem:item,wordListViewModel:wordListViewModel,wordNote: item.wordNote ?? "nullTag")){
                        VStack(alignment:.leading){
                            Text(item.wordContent ?? "noContent")
                                .font(.title3)
                            
                            Text(self.dealTrans(item.translation ?? "noTranslation").replacingOccurrences(of: "\n", with: "; "))
                                .font(.footnote)
                                .foregroundColor(Color(.systemGray))
                                .lineLimit(1)
                            //                            Text(item.translation?.replacingOccurrences(of: "\\n", with: "; ") ?? "noTranslation")
                            //                                .font(.subheadline)
                            //                                .foregroundColor(.gray)
                            //                                .lineLimit(1)
                            
                        }}
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        //            .navigationTitle("Word List")
        .navigationBarTitleDisplayMode(.inline)
        //            .toolbar { // <2>
        //                ToolbarItem(placement: .navigationBarLeading) { // <3>
        //                    Button {
        //                        self.wordItemController.deleteAll()
        //                    } label: {
        //                        Text("DeleteAll")
        //                    }
        //
        //                }
        //                ToolbarItem(placement: .navigationBarTrailing) {
        //                    Menu{
        //                        Button(action: {
        //                            self.wordItemController.createTestItem()
        //                        }) {
        //                            Label("Create Test", systemImage: "plus.circle")
        //                        }
        //                        Button(action: {
        //                            self.wordItemController.preloadFromCSV()
        //                        }) {
        //                            Label("Preload", systemImage: "text.badge.plus")
        //                        }
        //                    } label: {
        //                        Image(systemName: "ellipsis.circle")
        //                    }
        //                }
        //            }
        
        //        }
    }
    
    func dealTrans(_ rawTrans:String) -> String {
        let pattern1 = "^(vt|n|a|adj|adv|v|pron|prep|num|art|conj|vi|interj|r)(\\.| )"
        let regex1 = try! Regex(pattern1)
        
        //只替换第1个匹配项
        let out1 = regex1.replacingMatches(in: rawTrans, with: "[$1.] ", count: 1)
        
        
        
        let pattern2 = "n(vt|n|a|adj|adv|v|pron|prep|num|art|conj|vi|interj|r)(\\.| )"
        let regex2 = try! Regex(pattern2)
        //替换所有匹配项
        let out2 = regex2.replacingMatches(in: out1, with: "n[$1.] ")
        
        //        //输出结果
        //        print("原始的字符串：", rawTrans)
        //        print("替换第1个匹配项：", out1)
        //        print("替换所有匹配项：", out2)
        
        let result = out2.replacingOccurrences(of: "\\n", with: "\n")
        return result
    }
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView(wordListViewModel: WordListViewModel(),dataType: .searchResult)
    }
}

