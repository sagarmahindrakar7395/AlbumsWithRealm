//
//  ViewModel.swift
//  Albums
//
//  Created by Sagar Mahindrakar on 31/05/22.
//

import Foundation


class AlbumViewModel {
    
    var albums = [Album]()
    var photos = [[Photo]]()
    
    
    func getAlbums(){
    NetworkManger.sharedInstance.fetchGenericData(urlString: "https://jsonplaceholder.typicode.com/albums") { [weak self](albumsDetails: [Album]) in
        print("albumsDetails:\(albumsDetails)")
        self?.albums = albumsDetails
        if let albums = self?.albums{
            for data in albums {
                    DatabaseHelper.shared.saveAlbum(album:data)
            }
        }
        if let albums = self?.albums{
            for album in albums{
                let id = album.id
                self?.getPhotoDetails("\(id)")
            }
        }
    }
    }
    
    func getPhotoDetails(_ albumid:String){

        NetworkManger.sharedInstance.fetchGenericData(urlString: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumid)") { (photoDetails: [Photo]) in
            print("photoDetails:\(photoDetails)")
            self.photos.append(photoDetails)
            for photo in photoDetails{
                DatabaseHelper.shared.savePhoto(photo: photo)
            }
            DispatchQueue.main.async {
               // self.photoTableView.reloadData()
            }
        }
    }
    
    func getDataFromLocalDatabase(){
        albums = DatabaseHelper.shared.getAllAlbums()
        print("albums:\(albums)")
        let photosData = DatabaseHelper.shared.getAllPhotos()
        photos.append(photosData)
        print("photos:\(photos)")
    }

    func deleteLocalData() {
       DatabaseHelper.shared.deletAll()
   }
    
}
