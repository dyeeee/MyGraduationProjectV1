//
//  WordItemController.swift
//  MyVocabularyBook
//
//  Created by YES on 2020/11/27.
//

import Foundation
import CoreData
import SwiftUI

//目前ListViewModel一样，等跨数据需要跨多个页面的时候看怎么处理
class WordListViewModel: ObservableObject{
    @Published var itemList:[WordItem] = []
    @Published var searchResultList:[WordItem] = []
    @Published var notebookList:[WordItem] = []
    
    @Published var groupedStarLevelList:[[WordItem]] = []
    @Published var groupedABCList:[[WordItem]] = []
    
    
    enum ListName {
        case item
        case searchResult
        case notebook
    }
    
    init() {
        getAllItems()
        getGroupedItems()
    }
    
    func getItems(_ dataType:WordListType = .all) -> [WordItem] {
        if dataType == .all {
            return self.itemList
        }
        else if dataType == .searchResult {
            return self.searchResultList
        }
        else if dataType == .notebook{
            //getNotebookItems()
            return self.notebookList
        }
        else{
            return self.itemList
        }
    }
    
    func getAllItems() {
        let fetchRequest: NSFetchRequest<WordItem> = WordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true)
        
        
        fetchRequest.fetchLimit = 200
        //fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            itemList = try viewContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func getNotebookItems() {
        let fetchRequest: NSFetchRequest<WordItem> = WordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true)
        
        let starLevelFilter = "0"
        let pre =  NSPredicate(format: "starLevel > %@", starLevelFilter)
        
        fetchRequest.fetchLimit = 20
        fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            notebookList = try viewContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func getGroupedItems(_ by:String = "starLevel") {
        let fetchRequest: NSFetchRequest<WordItem> = WordItem.fetchRequest()
        let starLevelFilter = "0"
        let pre =  NSPredicate(format: "starLevel > %@", starLevelFilter)
        fetchRequest.fetchLimit = 50
        fetchRequest.predicate = pre
        let viewContext = PersistenceController.shared.container.viewContext
            //获取所有的Item
        
        var list:[WordItem] = []
        
        do {
            list = try viewContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")

        }

        let groupedByStarLevel = Dictionary(grouping: list)
        { (element: WordItem)  in
            element.starLevel
        }.values.sorted(){ $0[0].starLevel > $1[0].starLevel }
        
        let groupedByABC = Dictionary(grouping: list)
        { (element: WordItem)  in
            element.wordContent!.prefix(1).uppercased()
        }.values.sorted(){ $0[0].wordContent!.prefix(1) > $1[0].wordContent!.prefix(1) }
        
        self.groupedStarLevelList = groupedByStarLevel
        self.groupedABCList = groupedByABC
    }
    
    //查询
    func searchItems(begins:String) {
        let fetchRequest: NSFetchRequest<WordItem> = WordItem.fetchRequest()
        
        //WordItem.fetchRequest() 就是 NSFetchRequest<WordItem>(entityName: "WordItem"）
        let pre =  NSPredicate(format: "wordContent BEGINSWITH[c] %@", "\(begins)")
        let sort = NSSortDescriptor(key: "wordContent", ascending: true)
        
        fetchRequest.predicate = pre
        fetchRequest.fetchLimit = 20
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext

        do {
            searchResultList = try viewContext.fetch(fetchRequest)
             
        } catch {
            NSLog("Error fetching tasks: \(error)")

        }
    }
    
    func createTestItem() {
        let container = PersistenceController.shared.container
        let viewContext = container.viewContext
        
        for i in 0..<5{
            let wordItem = WordItem(context: viewContext)
            wordItem.wordContent = "Test-\(i)"
            wordItem.translation = "测试样例-\(i)"
        }
        
        saveToPersistentStoreAndRefresh(.item)
    }
    
    func preloadFromCSV() {
        let container = PersistenceController.shared.container
        let csvTool = CSVTools()
        
        var data = csvTool.readDataFromCSV(fileName: "Common_Wrods_Small", fileType: "csv")
        data = csvTool.cleanRows(file: data ?? "d")
        let csvRows = csvTool.csv(data: data ?? "d")
        
        container.performBackgroundTask() { (context) in
            for i in 1 ..< (csvRows.count - 1) {  //有标题就从1开始
                let word = WordItem(context: context)
                word.wordContent = csvRows[i][1]
                word.phonetic_EN = csvRows[i][2]
                word.phonetic_US = csvRows[i][3]
                word.definition = csvRows[i][4]
                word.translation = csvRows[i][5]
                word.wordTags = csvRows[i][6]
                word.wordExchanges = csvRows[i][7]
                word.bncLevel = Int16(csvRows[i][8]) ?? 0
                word.frqLevel = Int16(csvRows[i][9]) ?? 0
                word.collinsLevel = Int16(csvRows[i][10]) ?? 0
                word.oxfordLevel = Int16(csvRows[i][11]) ?? 0
                word.exampleSentences = csvRows[i][12]
                word.wordNote = ""
                word.starLevel = 0

            }
            do {
                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                try context.save()
                print("后台加载完成")
                //在主队列异步加载一次
                DispatchQueue.main.async {
                    self.getAllItems()
                    print("重新获取数据完成")
                }
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func preloadFromBigCSV() {
        let container = PersistenceController.shared.container
        let csvTool = CSVTools()
        
        var data = csvTool.readDataFromCSV(fileName: "Common_Words_3Sentences", fileType: "csv")
        data = csvTool.cleanRows(file: data ?? "d")
        let csvRows = csvTool.csv(data: data ?? "d")
        
        container.performBackgroundTask() { (context) in
            for i in 1 ..< (csvRows.count - 1) {  //有标题就从1开始
                let word = WordItem(context: context)
                word.wordContent = csvRows[i][1]
                word.phonetic_EN = csvRows[i][2]
                word.phonetic_US = csvRows[i][3]
                word.definition = csvRows[i][4]
                word.translation = csvRows[i][5]
                word.wordTags = csvRows[i][6]
                word.wordExchanges = csvRows[i][7]
                word.bncLevel = Int16(csvRows[i][8]) ?? 0
                word.frqLevel = Int16(csvRows[i][9]) ?? 0
                word.collinsLevel = Int16(csvRows[i][10]) ?? 0
                word.oxfordLevel = Int16(csvRows[i][11]) ?? 0
                word.exampleSentences = csvRows[i][12]
                word.wordNote = ""
                word.starLevel = 0

            }
            do {
                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                try context.save()
                print("后台加载完成")
                //在主队列异步加载一次
                DispatchQueue.main.async {
                    self.getAllItems()
                    print("重新获取数据完成")
                }
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    
    
    func deleteAll()  {
        let viewContext = PersistenceController.shared.container.viewContext
        let allItems = NSFetchRequest<NSFetchRequestResult>(entityName: "WordItem")
        let delAllRequest = NSBatchDeleteRequest(fetchRequest: allItems)
         do {
            try viewContext.execute(delAllRequest)
            print("删除全部数据")
            saveToPersistentStore()
         }
         catch { print(error) }
    }
    
    //更新， 传入一个Item实例对象, 修改这个实例
    func updateItem(ItemInstance: WordItem) {
        ItemInstance.wordContent = "test"
        saveToPersistentStore()
    }
    
    //保存
    func saveToPersistentStore() {
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            try viewContext.save()
            //getAllItems()
            print("完成保存")
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    //保存并刷新列表
    func saveToPersistentStoreAndRefresh(_ listName:ListName) {
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            try viewContext.save()
            getAllItems()
            if listName == .item {
                getAllItems()
            }else if listName == .notebook{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.getGroupedItems()
                }
            }else{
                getAllItems()
            }
            
            print("完成保存并重新给对应数据列表赋值")
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}