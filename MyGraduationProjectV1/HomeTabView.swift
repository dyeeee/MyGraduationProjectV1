//
//  HomeTabView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2020/12/27.
//

import SwiftUI

struct HomeTabView: View {
    @State var selectedTab: TabSelection = .page4
    @ObservedObject var wordItemController = WordItemController()
    
    var body: some View {
        TabView(selection: $selectedTab){
            Text("1")
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Progress")
                }
                .tag(TabSelection.page1)
            
            Text("Learn").navigationTitle(Text("page2"))
                .tabItem {
                    Image(systemName: "graduationcap.fill")
                    Text("Learn")
                }
                .tag(TabSelection.page2)
            
            Text("Note")
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Note")
                }
                .tag(TabSelection.page3)
            
            WordListView(wordItemController: wordItemController)
                .tabItem {
                    Image(systemName: "character.book.closed.fill")
                    Text("Dictionary")
                }
                .tag(TabSelection.page4)
            
            TextEditorAutoUp()
                .tabItem {
                    Image(systemName: "gearshape.2.fill")
                    Text("Setting")
                }
                .tag(TabSelection.page5)
        }
    }
}


enum TabSelection {
    case page1
    case page2
    case page3
    case page4
    case page5
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
