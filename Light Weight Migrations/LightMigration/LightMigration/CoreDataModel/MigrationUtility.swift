//
//  MigrationUtility.swift
//  LightMigration
//
//  Created by Sushant on 7/16/18.
//  Copyright © 2018 Striker. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Migration  {
    
    private static var sharedManager: Migration = {
        return Migration()
    }()
    
      // MARK: - Accessors
    
    class func shared() -> Migration {
        return sharedManager
    }
    
     let appDelegate =  UIApplication.shared.delegate as? AppDelegate
    
    
    func applicationDocumentsDirectory() -> String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last
    }
    
    func applicationStoresDirectory() -> URL! {
        
        let storesDirectory = URL(fileURLWithPath: self.applicationDocumentsDirectory()  ?? "")
        let fileManager = FileManager.default
        if !(fileManager.fileExists(atPath: storesDirectory.path )) {
            do {
                try fileManager.createDirectory(at: storesDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error")
            }
        }
        return storesDirectory
    }
    
    
    func migrateStore(sourceURL : URL , sourceMetadata : [AnyHashable : Any] ) -> Bool {
       
        do {
            let  sourceModel = NSManagedObjectModel.mergedModel(from: nil, forStoreMetadata: sourceMetadata as! [String : Any])
            let destinationModel = self.persistentContainer.managedObjectModel
            let mappingModel = try NSMappingModel.inferredMappingModel(forSourceModel: sourceModel!, destinationModel: destinationModel)
            
            let migrationManager = NSMigrationManager.init(sourceModel: sourceModel ?? NSManagedObjectModel(), destinationModel: destinationModel)
            var destinationStore = self.applicationStoresDirectory()
            var path = destinationStore?.path
            path = path ?? "" + "/Application Support/HeavyMigration.sqlite"
            destinationStore = URL.init(fileURLWithPath: path!)
            if ((try? migrationManager.migrateStore(from: sourceURL, sourceType: NSSQLiteStoreType, options: nil, with: mappingModel, toDestinationURL: destinationStore!, destinationType: NSSQLiteStoreType, destinationOptions: nil)) != nil) {
               // print("Migration Successed")
                if (self.replaceStore(oldStore:sourceURL, withNew: destinationStore!) ){
                 //       print("Migration Successed")
                    }
            }
        } catch {
            return false
        }
        return false
        
    }
    
    func replaceStore(oldStore : URL , withNew: URL) -> Bool {
        do {
            try FileManager.default.replaceItemAt(oldStore, withItemAt: withNew)
            return true
        } catch {
            return false
            
        }
    }
    
    
    func isMigrationRequired() {
        
        let docsDir     : URL       = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        let dbPath      : URL       = docsDir.appendingPathComponent("Application Support/LightMigration.sqlite")
        do{
            let sqliteExists : Bool = try dbPath.checkResourceIsReachable()
            if sqliteExists {
                let sourceMetaData = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: dbPath, options: nil)
                let destinationModel = self.persistentContainer.managedObjectModel
                if (destinationModel.isConfiguration(withName: nil, compatibleWithStoreMetadata: sourceMetaData)) {
                    print("SKIPPED MIGRATION: Source is already compatible")
                } else {
                    let success =  self.migrateStore(sourceURL: dbPath, sourceMetadata: sourceMetaData)
                    print(success)
                }
            }
        }catch{
            print("SQLite NOT Found at ")
        }
    }
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "LightMigration")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func changPersistentStore() {
      //  self.persistentContainer =
    }
}
