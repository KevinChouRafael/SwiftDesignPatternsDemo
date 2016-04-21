//
//  LibraryAPI.swift
//  BlueLibrarySwift
//
//  Created by rafael on 4/20/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import Foundation
import UIKit


class LibraryAPI: NSObject {
    
    //静态变量 sharedInstance。  swift1.2之前。
//    class var sharedInstance: LibraryAPI {
//
//        struct Singleton {
//            
//            //静态常量
//            //static 变量是延时加载的。
//            static let instance = LibraryAPI()
//        }
//        
//        return Singleton.instance
//    }
    
    static let sharedInstance = LibraryAPI()

    
    private let persistencyManager: PersistencyManager
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    //Facade ,外观模式，封装了调用细节。
    private override init() {
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = false
        
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(LibraryAPI.downloadImage(_:)), name: "BLDownloadImageNotification", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func getAlbums() -> [Album] {
        return persistencyManager.getAlbums()
    }
    
    //Facade ,外观模式，封装了调用细节。
    func addAlbum(album: Album, index: Int) {
        persistencyManager.addAlbum(album, index: index)  //本地缓存
        if isOnline {  //网络请求
            httpClient.postRequest("/api/addAlbum", body: album.description )
        }
    }
    
    func deleteAlbum(index: Int) {
        persistencyManager.deleteAlbumAtIndex(index)
        if isOnline {
            httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }
    
    func downloadImage(notification: NSNotification) {
        //1
        let userInfo = notification.userInfo as! [String: AnyObject]
        let imageView = userInfo["imageView"] as! UIImageView?
        let coverUrl = userInfo["coverUrl"] as! NSString
        
        //2
        if let imageViewUnWrapped = imageView {
            imageViewUnWrapped.image = persistencyManager.getImage(coverUrl.lastPathComponent)
            if imageViewUnWrapped.image == nil {
                //3
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                    let downloadedImage = self.httpClient.downloadImage(coverUrl as String)
                    //4
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        imageViewUnWrapped.image = downloadedImage
                        self.persistencyManager.saveImage(downloadedImage, filename: coverUrl.lastPathComponent)
                    })
                })
            }
        }
    }
    
}