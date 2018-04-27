//
//  CardService.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/27/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class CardService {
    
    let httpService: HTTPService
    
    private static var sharedService: CardService = {
        let service = CardService()
        return service
    }()
    
    private init() {
        self.httpService = HTTPService.shared()
        print("CardService initialized..")
    }
    
    class func shared() -> CardService {
        return sharedService
    }
    
    func syncCards(onSync: (() -> ())?) {
        
        Business.shared().cards?.clear()
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            
            if(error != "") {
                print("Error in syncCards()")
            } else {
                if let cards = data["data"] as? [String: Any] {
                    print("received cards from server, card count = \(cards.count)")
                    for _card in cards {                        
                        let card = _card.value as! [String: Any]
                        let id = _card.key
                        let type = card["type"] as! String
                        let nameOnCard = card["nameOnCard"] as! String
                        let number = card["number"] as! String
                        let expMonth = card["expMonth"] as! String
                        let expYear = card["expYear"] as! String
                        let cvv = card["cvv"] as! String
                        
                        // add card to model
                        Business.shared().cards?.addCreditCard(id: id, number: number, nameOnCard: nameOnCard, expiryMonth: expMonth, expiryYear: expYear, cvv: cvv, type: type)
                    }
                }
            }
            print("synced cards from server, card count = \((Business.shared().cards?.cards.count)!)")
            NotificationCenter.default.post(name: .cardsSynced, object: nil)
            onSync?()
        }
        httpService.get(url: "cards", completionHandler: completionHandler)
    }
    
    
    func addCard(userId: String, type: String, nameOnCard: String, number: String, expMonth: String, expYear: String, cvv: String) {
        
        var card = [String: Any]()
        card["type"] = type
        card["nameOnCard"] = nameOnCard
        card["number"] = number
        card["expMonth"] = expMonth
        card["expYear"] = expYear
        card["cvv"] = cvv
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding card to firebase, error = \(error)")
            } else {
                print("Success in adding card to firebase")
                print("data = \(data)")
                if let res = data["data"] as? [String: Any] {
                    if let cardId = res["name"] as? String {
                        print("cardId = \(cardId)")
                        // add the cardId to user
                        UserService.shared().addCardToUser(userId: userId, cardId: cardId)
                    }
                }
                self.syncCards(onSync: nil)
            }
        }
        httpService.post(url: "cards", data: card, completionHandler: completionHandler)
    }
    
    func updateCard(cardId: String, type: String, nameOnCard: String, number: String, expMonth: String, expYear: String, cvv: String) {
        
        var card = [String: Any]()
        card["type"] = type
        card["nameOnCard"] = nameOnCard
        card["number"] = number
        card["expMonth"] = expMonth
        card["expYear"] = expYear
        card["cvv"] = cvv
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in updating card to firebase, error = \(error)")
            } else {
                print("Success in updating card to firebase")
                self.syncCards(onSync: nil)
            }
        }
        httpService.patch(url: "cards/\(cardId)", data: card, completionHandler: completionHandler)
    }
    
}
