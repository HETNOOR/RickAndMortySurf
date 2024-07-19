//
//  NSCache.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 17.07.2024.
//

import Foundation

protocol NSCacheStoreDatasource {
    associatedtype Key: Hashable
    associatedtype Value
    func save(_ value: Value, forkey key: Key)
    func retrieve(forkey key: Key) -> Value?
    func removeValue (forKey key: Key)
    subscript(key: Key) -> Value? { get set }
}

//class DefaultNSCacheStoreDatasource <Key: Hashable, Value >: NSCacheStoreDatasource {
//    func save(_ value: Value, forkey key: Key) {
//        <#code#>
//    }
//    
//    func retrieve(forkey key: Key) -> Value? {
//        <#code#>
//    }
//    
//    func removeValue(forKey key: Key) {
//        <#code#>
//    }
//    
//    subscript(key: Key) -> Value? {
//        get {
//            <#code#>
//        }
//        set {
//            <#code#>
//        }
//    }
//    
//    
//}
