//
//  CreditCard+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class CreditCard: NSManagedObject {
    
    static let shared = CreditCard()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllCreditCards() -> [CreditCard] {
        var creditCards = [CreditCard]()
        do {
            creditCards = try context.fetch(CreditCard.fetchRequest())
        } catch {
            print("Error fetching creditCards from CoreData")
        }
        return creditCards
    }
    
    func getCreditCard(id: String) -> CreditCard? {
        for creditCard in getAllCreditCards() {
            if(creditCard.id == id) {
                return creditCard
            }
        }
        return nil
    }
    
    func addCreditCard(id: String, number: String, nameOnCard: String, expiryMonth: String, expiryYear: String, cvv: String, zip: String, type: String) {
        
        let creditCard = CreditCard(context: context)
        
        creditCard.id = id
        creditCard.number = number
        creditCard.nameOnCard = nameOnCard
        creditCard.expiryMonth = expiryMonth
        creditCard.expiryYear = expiryYear
        creditCard.cvv = cvv
        creditCard.zip = zip
        creditCard.type = type
        
        appDelegate.saveContext()
    }
    
    func editCreditCard(id: String, number: String, nameOnCard: String, expiryMonth: String, expiryYear: String, cvv: String, zip: String, type: String) {
        
        guard let creditCard = getCreditCard(id: id) else {
            print("Error fetching credit card with id = \(id) to edit in CoreData")
            return
        }
        
        creditCard.number = number
        creditCard.nameOnCard = nameOnCard
        creditCard.expiryMonth = expiryMonth
        creditCard.expiryYear = expiryYear
        creditCard.cvv = cvv
        creditCard.zip = zip
        creditCard.type = type
        
        appDelegate.saveContext()
        
    }
    
    func clear() {
        for creditCard in getAllCreditCards(){
            context.delete(creditCard)
        }
        appDelegate.saveContext()
    }
    
}
