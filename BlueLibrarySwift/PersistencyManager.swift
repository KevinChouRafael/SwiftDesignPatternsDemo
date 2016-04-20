//
//  PersistencyManager.swift
//  BlueLibrarySwift
//
//  Created by rafael on 4/20/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import Foundation

class PersistencyManager: NSObject {
    
    private var albums = [Album]()
    
    override init() {
        //Dummy list of albums
        let album1 = Album(title: "Best of Bowie",
                           artist: "David Bowie",
                           genre: "Pop",
                           coverUrl: "http://img3.douban.com/mpic/s1497881.jpg",
                           year: "1992")
        
        let album2 = Album(title: "It's My Life",
                           artist: "No Doubt",
                           genre: "Pop",
                           coverUrl: "http://img3.doubanio.com/mpic/s3880529.jpg",
                           year: "2003")
        
        let album3 = Album(title: "Nothing Like The Sun",
                           artist: "Sting",
                           genre: "Pop",
                           coverUrl: "http://img3.doubanio.com/mpic/s3708339.jpg",
                           year: "1999")
        
        let album4 = Album(title: "Staring at the Sun",
                           artist: "U2",
                           genre: "Pop",
                           coverUrl: "http://img3.douban.com/mpic/s1882422.jpg",
                           year: "2000")
        
        let album5 = Album(title: "American Pie",
                           artist: "Madonna",
                           genre: "Pop",
                           coverUrl: "http://img3.douban.com/mpic/s3105351.jpg",
                           year: "2000")
        
        albums = [album1, album2, album3, album4, album5]
    }
    
    
    func getAlbums() -> [Album] {
        return albums
    }
    
    func addAlbum(album: Album, index: Int) {
        if (albums.count >= index) {
            albums.insert(album, atIndex: index)
        } else {
            albums.append(album)
        }
    }
    
    func deleteAlbumAtIndex(index: Int) {
        albums.removeAtIndex(index)
    }
    
}