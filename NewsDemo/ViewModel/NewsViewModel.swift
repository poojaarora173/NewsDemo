//
//  NewsViewModel.swift
//  NewsDemo
//
//  Created by Pooja Arora on 26/03/22.
//

import Foundation
import ObjectMapper
import CoreData
import UIKit

class NewsViewModel{
    //MARK:- ======== Variable Declaration ========
    static var instance: NewsViewModel = NewsViewModel()
    
    var aryNewsModel = [NewsModel]()
    var news: [NSManagedObject] = []
    
    //MARK:- Login API Call
    func getNewsList( completion: @escaping (Bool, String) -> Void) {
        Webservice.News.getNewsList.requestWith(parameter: [:]) { (result) in
            print("Response from News List is is",result)
            switch result {
            case .success(let response):
                if let body = response.body{
                    if let bodyData = body["articles"] as? [[String : Any]] {
                        self.aryNewsModel = Mapper<NewsModel>().mapArray(JSONArray: bodyData )
                    }
                    UserDefaults.standard.set(true, forKey: "kDataAdded")
                    //Save data in Coredata
                    for newsModel in self.aryNewsModel{
                        self.save(newsModel: newsModel)
                    }
                    completion(true, body["message"] as? String ?? "")
                }
            case .fail(let error):
                completion(false, error.message)
            }
        }
    }
    //Database manager
    func save(newsModel: NewsModel) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "News",
                                   in: managedContext)!
      
      let newsDbModel = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
        newsDbModel.setValue(newsModel.urlToImage, forKeyPath: "newsImage")
        newsDbModel.setValue(newsModel.author, forKeyPath: "newsAuthor")
        newsDbModel.setValue(newsModel.publishedAt, forKeyPath: "newsDate")
        newsDbModel.setValue(newsModel.description, forKeyPath: "newsDescription")
        newsDbModel.setValue(newsModel.title, forKeyPath: "newsTitle")
        newsDbModel.setValue(newsModel.url, forKeyPath: "newsWeblink")
      
      // 4
      do {
        try managedContext.save()
          news.append(newsDbModel)
          print("Data added.......")
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    func fetchAllNewsList(){
        
        
        /*Before you can do anything with Core Data, you need a managed object context. */
        let managedContext = appDelegate.persistentContainer.viewContext
        
        /*As the name suggests, NSFetchRequest is the class responsible for fetching from Core Data.
         
         Initializing a fetch request with init(entityName:), fetches all objects of a particular entity. This is what you do here to fetch all Person entities.
         */
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "News")
        
        /*You hand the fetch request over to the managed object context to do the heavy lifting. fetch(_:) returns an array of managed objects meeting the criteria specified by the fetch request.*/
        do {
            let resultData = try managedContext.fetch(fetchRequest)
            print("Result data",resultData)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    func fetch() -> [News]{
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "News")
                
        do {
             let results   = try managedContext.fetch(fetchRequest)
             let locations = results as! [News]
                
             for location in locations {
                 print(location.newsTitle)
             }
            return locations

        } catch let error as NSError {
          print("Could not fetch \(error)")
        }
        return [News]()
    }

}




