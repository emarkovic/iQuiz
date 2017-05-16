//
//  Category.swift
//  iQuiz
//
//  Created by Personal on 5/4/17.
//  Copyright © 2017 Ena Markovic. All rights reserved.
//

import UIKit
import CoreData

func extractJsonAndSave(json: Data) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let jsonData = try! JSONSerialization.jsonObject(with: json, options: [])
    if let array = jsonData as? [[String:Any]] {
        for cat in array {
            print(context)
            let category = Category1(context: context)
            
            if let title = cat["title"] as? String {
                category.title = title
            }
            if let desc = cat["desc"] as? String {
                category.desc = desc
            }
            
            if let questions = cat["questions"] as? [[String:Any]] {
                for quest in questions {
                    let question = Question1(context: context)
                    let catQuest = Category_Question(context: context)
                    
                    if let text = quest["text"] as? String {
                        question.text = text
                    }
                    if let answer = quest["answer"] as? String {
                        question.answer = answer
                    }
                    if let answers = quest["answers"] as? [String] {
                        question.optionA = answers[0]
                        question.optionB = answers[1]
                        question.optionC = answers[2]
                        question.optionD = answers[3]
                    }
                    
                    catQuest.category = category
                    catQuest.question = question
                }
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }
}

func getAllData() -> [String: Category] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequestCatQuest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category_Question")
    
    var quizData = [String:Category]()
    
    do {
       let catQuest = try context.fetch(fetchRequestCatQuest)
        
        for cq in catQuest {
            let cqCat = (cq as! NSManagedObject).value(forKey: "category") as! NSManagedObject
            let cqQuest = (cq as! NSManagedObject).value(forKey: "question") as! NSManagedObject
            let categoryTitle = cqCat.value(forKey: "title") as! String!
            
            if quizData[categoryTitle!] == nil {
                var image = ""
                switch categoryTitle! {
                case "Mathematics":
                    image = "math"
                case "Science!":
                    image = "science"
                case "Marvel Super Heroes":
                    image = "marvel"
                default:
                    image = "placeholder"
                }
                quizData[categoryTitle!] = Category(title: categoryTitle!, subtitle: cqCat.value(forKey: "desc") as! String, questions: [], imageName: image)
            }
            
            let q = Question(question: cqQuest.value(forKey: "text") as! String, answers: [
                    cqQuest.value(forKey: "optionA") as! String,
                    cqQuest.value(forKey: "optionB") as! String,
                    cqQuest.value(forKey: "optionC") as! String,
                    cqQuest.value(forKey: "optionD") as! String
                ], correctAnsIndex: Int(cqQuest.value(forKey: "answer") as! String)! - 1)
            
            quizData[categoryTitle!]?.addQuestion(question: q)
        }
        
        return quizData;
        
    } catch {
        print("failed getting data")
    }
    
    return [String:Category]()
}

func deleteAllData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequestCat = NSFetchRequest<NSFetchRequestResult>(entityName: "Category1")
    let deleteRequestCat = NSBatchDeleteRequest(fetchRequest: fetchRequestCat)
    
    let fetchRequestQuest = NSFetchRequest<NSFetchRequestResult>(entityName: "Question1")
    let deleteRequestQuest = NSBatchDeleteRequest(fetchRequest: fetchRequestQuest)
    
    let fetchRequestCatQuest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category_Question")
    let deleteRequestCatQuest = NSBatchDeleteRequest(fetchRequest: fetchRequestCatQuest)
    
    do {
        try context.execute(deleteRequestCat)
        try context.execute(deleteRequestQuest)
        try context.execute(deleteRequestCatQuest)
        
        try context.save()
    } catch {
        print ("There was an error")
    }
}

class Category {
    var title: String
    var subtitle: String
    var questions: [Question]
    var image: UIImage
    
    init(title: String, subtitle: String, questions: [Question], imageName: String) {
        self.title = title
        self.subtitle = subtitle
        self.questions = questions
        self.image = UIImage(named: imageName)!
    }
    
    func addQuestion(question: Question) {
        self.questions.append(question)
    }
}

class Question {
    var question: String
    var answers: [String]
    var correctAnsIndex: Int
    
    init(question: String, answers: [String], correctAnsIndex: Int) {
        self.question = question
        self.answers = answers
        self.correctAnsIndex = correctAnsIndex
    }
}
