//
//  DataBaseHelper.swift
//  Albums
//
//  Created by Sagar Mahindrakar on 29/05/22.
//

import Foundation
import RealmSwift

class DatabaseHelper{

    static let shared = DatabaseHelper()

    
    private init(){
        
    }
    
let realmD = try! Realm()
    
    func getDatabaseURL()->URL?{
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    func saveAlbum(album:Album){
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                    realm.beginWrite()
                        realm.create(Album.self, value: album)
                    try! realm.commitWrite()
            }
        }
    }
    
    func savePhoto(photo:Photo){
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                    realm.beginWrite()
                        realm.create(Photo.self, value: photo)
                    try! realm.commitWrite()
            }
        }
    }

    func deletAlbum(album:Album){
        let realm = try! Realm()
        try!realm.write{
            realm.delete(album)
        }
    }

    func getAllAlbums()->[Album]{
        let realm = try! Realm()
        return Array(realm.objects(Album.self))
    }
    
    func getAllPhotos()->[Photo]{
        let realm = try! Realm()
        return Array(realm.objects(Photo.self))
    }

    func deletAll(){
//        let realm = try! Realm()
//        try! realm.write {
//            realm.deleteAll()
//        }
        
        do{
        let result = realmD.objects(Album.self)
        try realmD.write {
            realmD.delete(result)
        }
        } catch let error as NSError {
            print("error -\(error.localizedDescription)")
        }
        
        do{
        let result = realmD.objects(Photo.self)
        try realmD.write {
            realmD.delete(result)
        }
        } catch let error as NSError {
            print("error -\(error.localizedDescription)")
        }

    }
    
}
