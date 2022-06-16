//
//  AlbumsDataModels.swift
//  Albums
//
//  Created by Sagar Mahindrakar on 27/05/22.
//

import Foundation
import RealmSwift


// MARK: - Album
class Album: Object, Codable {
    @Persisted var userID: Int
    @Persisted var id: Int
    @Persisted var title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id = "id"
        case title = "title"
    }
    
    convenience init(userID:Int, id: Int, title: String){
        self.init()
        self.userID = userID
        self.id = id
        self.title = title
    }
}

// MARK: - Photo
class Photo: Object,Codable, Comparable {
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.albumID < rhs.albumID
    }
    
    @Persisted var  albumID: Int
    @Persisted var  id: Int
    @Persisted var  title: String
    @Persisted var  url: String
    @Persisted var  thumbnailURL: String
    
    convenience init(albumID:Int, id: Int, title: String, url: String,thumbnailURL:String ){
        self.init()
        self.albumID = albumID
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailURL = thumbnailURL
    }

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailURL = "thumbnailUrl"
    }
}


