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

func getAllData() -> [Category] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequestCatQuest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category_Question")
    
    do {
        var mathCategory: Category?
        var scienceCategory: Category?
        var marvelCategory: Category?
        
        var mathQuestions: [Question] = []
        var scienceQuestions: [Question] = []
        var marvelQuestions: [Question] = []
        
        let catQuest = try context.fetch(fetchRequestCatQuest)
        
        // fill up the questions
        for cq in catQuest {
            let cqCat = (cq as! NSManagedObject).value(forKey: "category") as! NSManagedObject
            let cqQuest = (cq as! NSManagedObject).value(forKey: "question") as! NSManagedObject
            
            let q = Question(question: cqQuest.value(forKey: "text") as! String, answers: [
                cqQuest.value(forKey: "optionA") as! String,
                cqQuest.value(forKey: "optionB") as! String,
                cqQuest.value(forKey: "optionC") as! String,
                cqQuest.value(forKey: "optionD") as! String
                ], correctAnsIndex: Int(cqQuest.value(forKey: "answer") as! String)! - 1)
            
            let categoryTitle = cqCat.value(forKey: "title") as! String!
            if categoryTitle == "Mathematics" {
                mathQuestions.append(q)
            } else if categoryTitle == "Science!" {
                scienceQuestions.append(q)
            } else if categoryTitle == "Marvel Super Heroes" {
                marvelQuestions.append(q)
            }
        }
        
        // fill up the category
        for cq in catQuest {
            let cqCat = (cq as! NSManagedObject).value(forKey: "category") as! NSManagedObject
            
            let categoryTitle = cqCat.value(forKey: "title") as! String!
            if categoryTitle == "Mathematics" {
                if mathCategory == nil {
                    mathCategory = Category(title: cqCat.value(forKey: "title") as! String, subtitle: cqCat.value(forKey: "desc") as! String, questions: mathQuestions, imageName: "math")
                }
            } else if categoryTitle == "Science!" {
                if scienceCategory == nil {
                    scienceCategory = Category(title: cqCat.value(forKey: "title") as! String, subtitle: cqCat.value(forKey: "desc") as! String, questions: scienceQuestions, imageName: "science")
                }
            } else if categoryTitle == "Marvel Super Heroes" {
                if marvelCategory == nil {
                    marvelCategory = Category(title: cqCat.value(forKey: "title") as! String, subtitle: cqCat.value(forKey: "desc") as! String, questions: marvelQuestions, imageName: "marvel")
                }
            }
        }
        
        return [mathCategory!, scienceCategory!, marvelCategory!]
        
    } catch {
        print("failed getting data")
    }
    
    return []
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

var data = [
    Category(
        title: "Mathematics",
        subtitle: "Questions about math",
        questions: [
            Question(question: "Which of the following is a subset of  {b, c, d}?", answers: [
                "{ }",
                "{a}",
                "{1 , 2 , 3}",
                "{a, b, c}"
            ], correctAnsIndex: 0),
            Question(question: "The value of 5 in the number  357.21 is...", answers: [
                "5 tenths",
                "5 ones",
                "5 tens",
                "5 hundreds"
            ], correctAnsIndex: 2),
            Question(question: "In coordinate geometry, the equation of the x-axis is", answers: [
                "y = x",
                "y = 0",
                "x = 0",
                "y = 1"
            ], correctAnsIndex: 1),
            Question(question: "3x - 4(x + 6) =", answers: [
                "x + 6",
                "-x - 24",
                "7x + 6",
                "-7x - 24"
            ], correctAnsIndex: 1),
            Question(question: " 3 4/5 expressed as a decimal is...", answers: [
                "3.40",
                "3.45",
                "3.50",
                "3.80"
            ], correctAnsIndex: 3)
        ],
        imageName: "math"
    ),
    Category(
        title: "Marvel Super Heroes",
        subtitle: "Questions about marvel",
        questions: [
            Question(question: "The Fantastic Four have the headquarters in what building?", answers: [
                "Stark Tower",
                "Fantastic Headquarters",
                "Baxter Building",
                "Xavier Institute"
            ], correctAnsIndex: 2),
            Question(question: "Peter Parker works as a photographer for:", answers: [
                "The Daily Planet",
                "The Daily Bugle",
                "The New York Times",
                "The Rolling Stone"
            ], correctAnsIndex: 1),
            Question(question: "Thor has two war goats to pull his chariot. They are named:", answers: [
                "Balder and Hermod",
                "Thunder and Lightning",
                "Ask and Embla",
                "Toothgrinder and Toothgnasher"
            ], correctAnsIndex: 3),
            Question(question: "Before becoming Radioactive Man, Chen Lu was:", answers: [
                "A spy",
                "A nuclear physicist",
                "A soldier",
                "A pilot"
            ], correctAnsIndex: 1),
            Question(question: "S.H.I.E.L.D.'s highest ranking agent is:", answers: [
                "Nick Fury",
                "Steven Rogers",
                "Peter Parker",
                "Natalia Romanova"
            ], correctAnsIndex: 0)
        ],
        imageName: "marvel"
    ),
    Category(
        title: "Science",
        subtitle: "Questions about science",
        questions: [
            Question(question: "Who invented the miner's safety-lamp?", answers: [
                "Sir Frank Whittle",
                "Alexander Graham Bell",
                "Thomas Alva Edison",
                "Sir Humphrey Davy"
            ], correctAnsIndex: 3),
            Question(question: "Which gas in the atmosphere protects us from harmful ultraviolet radiations?", answers: [
                "Ozone",
                "Oxygen",
                "Nitrogen",
                "Carbon Dioxide"
            ], correctAnsIndex: 0),
            Question(question: "The sun is a...", answers: [
                "Huge planet",
                "Star",
                "Comet",
                "Satellite"
            ], correctAnsIndex: 1),
            Question(question: "Who discovered the circulation of blood?", answers: [
                "Edward Jenner",
                "Hargobind Khorana",
                "William Harvey",
                "Louis Pasteur"
            ], correctAnsIndex: 2),
            Question(question: "What is the total number of bones in the human body?", answers: [
                "32",
                "196",
                "206",
                "512"
            ], correctAnsIndex: 2),
        ],
        imageName: "science"
    )
]

