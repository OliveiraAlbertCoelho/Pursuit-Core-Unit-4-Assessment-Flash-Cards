//
//  ImagePersistence.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct CardPersistence{
    private init(){}
    static let manager = CardPersistence()
    private let persistenceHelper = PersistenceHelper<flashCard>(fileName: "cardData.plist")
    
    func getImage() throws -> [flashCard]{
        
        return try persistenceHelper.getObjects()
    }
    func saveImage(info: flashCard) throws{
        try persistenceHelper.save(newElement: info)
    }
    func deleteImage(Int: Int) throws{
        try persistenceHelper.delete(num: Int)
    }
    func editImage(Int: Int, newElement: flashCard) throws{
        try persistenceHelper.edit(num: Int, newElement: newElement)
    }
}
