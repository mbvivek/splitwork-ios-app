//
//  Payment+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Payment: NSManagedObject {
    
    static let shared = Payment()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllPayments() -> [Payment] {
        var payments = [Payment]()
        do {
            payments = try context.fetch(Payment.fetchRequest())
        } catch {
            print("Error fetching payments from CoreData")
        }
        return payments
    }
    
    func getPayment(id: String) -> Payment? {
        for payment in getAllPayments() {
            if(payment.id == id) {
                return payment
            }
        }
        return nil
    }
    
    func addPayment(id: String, amount: Double, fromUsername: String, toUsername: String, fromCreditCardId: String, toCreditCardId: String, date: Date, status: String) {
        
        let payment = Payment(context: context)
        payment.id = id
        payment.amount = amount
        
        if let fromUser = User.shared.getUser(username: fromUsername) {
            payment.fromUser = fromUser
        } else {
            print("Error fetching user with username = \(fromUsername) to add payment in CoreData")
        }

        if let toUser = User.shared.getUser(username: toUsername) {
            payment.toUser = toUser
        } else {
            print("Error fetching user with username = \(toUsername) to add payment in CoreData")
        }

        if let fromCreditCard = CreditCard.shared.getCreditCard(id: fromCreditCardId) {
            payment.fromCreditCard = fromCreditCard
        } else {
            print("Error fetching credit card with id = \(fromCreditCardId) to add payment in CoreData")
        }
        
        if let toCreditCard = CreditCard.shared.getCreditCard(id: toCreditCardId) {
            payment.toCreditCard = toCreditCard
        } else {
            print("Error fetching credit card with id = \(toCreditCardId) to add payment in CoreData")
        }
        
        payment.date = date as NSDate
        payment.status = status
    }
    
    func clear() {
        for payment in getAllPayments(){
            context.delete(payment)
        }
        appDelegate.saveContext()
    }
    
}
