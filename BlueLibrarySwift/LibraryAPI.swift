//
//  LibraryAPI.swift
//  BlueLibrarySwift
//
//  Created by rafael on 4/20/16.
//  Copyright © 2016 Raywenderlich. All rights reserved.
//

import Foundation



class LibraryAPI: NSObject {
    
    //静态变量 sharedInstance。
    class var sharedInstance: LibraryAPI {

        struct Singleton {
            
            //静态常量
            //static 变量是延时加载的。
            static let instance = LibraryAPI()
        }
        
        return Singleton.instance
    }
    
    private let persistencyManager: PersistencyManager
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    //Facade ,外观模式，封装了调用细节。
    override init() {
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = false
        
        super.init()
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
    
    
}