//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Personal on 5/9/17.
//  Copyright © 2017 Ena Markovic. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var question: Question?
    
    var quizData: [String:Category]?
    var categoryClicked: String?
    var currentQuestionIndex: Int?
    var numCorrect: Int?
    
    var userAnswer: Int?
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var userAnswerLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let question = self.quizData?[self.categoryClicked!]?.questions[self.currentQuestionIndex!]
        
        questionLabel.text = question!.question
        userAnswerLabel.text = question!.answers[userAnswer!]
        correctAnswerLabel.text = question!.answers[question!.correctAnsIndex]
        if userAnswer == question!.correctAnsIndex {
            numCorrect! += 1
            resultLabel.text = "Correct!"
            resultLabel.textColor = UIColor.green
        } else {
            resultLabel.text = "Incorrect"
            resultLabel.textColor = UIColor.red
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        let nextQuestionIndex = currentQuestionIndex! + 1
        let categoryQuestions = self.quizData?[self.categoryClicked!]?.questions
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
        if nextQuestionIndex > (categoryQuestions?.count)! - 1 {
            
            let endVC = storyBoard.instantiateViewController(withIdentifier: "QuizResultsView") as! EndViewController
            endVC.results = numCorrect
            endVC.totalQuestions = categoryQuestions?.count
            self.present(endVC, animated:true, completion:nil)
            
        } else {
            
            let questionVC = storyBoard.instantiateViewController(withIdentifier: "QuestionView") as! QuestionViewController
            questionVC.quizData = self.quizData
            questionVC.currentQuestionIndex = self.currentQuestionIndex! + 1
            questionVC.categoryClicked = self.categoryClicked
            questionVC.numCorrect = numCorrect!
            self.present(questionVC, animated:true, completion:nil)
        
        }
        
    }
    

}
