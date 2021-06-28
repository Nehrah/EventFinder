//
//  Cache.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021.
//
//

import Foundation

class Cache<T: Codable & Hashable> {
    
    private var memoryCache: MemoryCache<T>?
    private var diskCache: DiskCache<T>?
    
    init(cacheName: String, useMemoryCache: Bool = true, useDiskCache: Bool = true) {
        if useMemoryCache {
            memoryCache = MemoryCache(cacheName: cacheName)
        }
        if useDiskCache {
            diskCache = DiskCache(cacheName: cacheName)
        }
    }
    
    func setObject(object: Set<T>, key: String) {
        memoryCache?.setObject(object: object, key: key)
        diskCache?.setObject(object: object, key: key)
    }
    
    func object(key: String) -> Set<T>? {
        var object: Set<T>?
        if let memoryObject = memoryCache?.object(key: key) {
            object = memoryObject
        } else if let diskObject = diskCache?.object(key: key) {
            object = diskObject
            memoryCache?.setObject(object: diskObject, key: key)
        }
        return object
    }
    
    func removeCache() {
        memoryCache?.removeCache()
        diskCache?.removeCache()
    }
}
