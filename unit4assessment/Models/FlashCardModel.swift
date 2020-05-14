//
//  FlashCardModel.swift
//  unit4assessment
//
//  Created by albert coelho oliveira on 10/24/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation


struct CardsWrapper: Codable{
    let cards: [flashCard]
 
}
struct flashCard: Codable{
    let id: String?
    let cardTitle: String
    let facts: [String]
    func checkCards() -> Bool? {
         do {
             let savedCard = try CardPersistence.manager.getImage()
             if savedCard.contains(where: {$0.id == self.id}) {
                 return true
             } else {
                 return false
             }
         } catch {
             print(error)
             return nil
         }
     }
}
