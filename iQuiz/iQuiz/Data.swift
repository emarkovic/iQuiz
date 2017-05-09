//
//  Category.swift
//  iQuiz
//
//  Created by Personal on 5/4/17.
//  Copyright © 2017 Ena Markovic. All rights reserved.
//

import UIKit

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
    var correctAnsIndex: number
    
    init(question: String, answers: [String], correctAnsIndex: number) {
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

