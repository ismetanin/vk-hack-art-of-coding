//
//  FirebaseDatabase.swift
//  ARLocatorTest
//
//  Created by Gregory Berngardt on 10/11/2018.
//  Copyright © 2018 gregoryvit. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CodableFirebase

typealias GeoItemHandler = ([GeoItem]) -> Void

class FirebaseDatabase {
    
    var ref: DatabaseReference!
    
    var itemsUpdate: GeoItemHandler?
    var itemsRemove: GeoItemHandler?
    
    init() {
        ref = Database.database().reference()
    }
    
    public func startListenItems() {
        let itemsRef = ref.child("items")

        itemsRef.observe(.childRemoved, with: { (snapshot) -> Void in
            guard let value = snapshot.value else { return }
            do {
                let item = try FirebaseDecoder().decode(GeoItem.self, from: value)
                
                self.itemsRemove?([item])
                
            } catch let error {
                print(error)
            }
        })
        
        itemsRef.observe(.value) { (snapshot) in
            let items = snapshot.children.compactMap({ (childSnapshot) -> GeoItem? in
                guard let childSnapshot = childSnapshot as? DataSnapshot, let value = childSnapshot.value else { return nil }
                do {
                    let item = try FirebaseDecoder().decode(GeoItem.self, from: value)
                    return item
                } catch let error {
                    print(error)
                    return nil
                }
            })
            
            self.itemsUpdate?(items)
        }
    }
    
    public func postItem(_ item: GeoItem) {
        let data = try! FirebaseEncoder().encode(item)
        ref.child("items").child(item.id).setValue(data)
        
        
    }
}
