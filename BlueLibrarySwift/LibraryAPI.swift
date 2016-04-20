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
    
}