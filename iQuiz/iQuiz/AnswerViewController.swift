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
    var currentQuestionIndex: Int?
    var categoryIndex: Int?
    var userAnswer: Int?
    var numCorrect: Int?
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var userAnswerLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let categoryQuestions = data[categoryIndex!].questions
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
        
        if nextQuestionIndex > categoryQuestions.count - 1 {
            let endVC = storyBoard.instantiateViewController(withIdentifier: "QuizResultsView") as! EndViewController
            endVC.results = numCorrect
            self.present(endVC, animated:false, completion:nil)
        } else {
            let questionVC = storyBoard.instantiateViewController(withIdentifier: "QuestionView") as! QuestionViewController
            questionVC.questions = data[categoryIndex!].questions
            questionVC.currentQuestionIndex = currentQuestionIndex! + 1
            questionVC.categoryIndex = categoryIndex!
            questionVC.numCorrect = numCorrect!
            self.present(questionVC, animated:false, completion:nil)
        }
        
        
        
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////
////        if segue.identifier == "ToQuestFromAns" {
////            let destination = segue.destination as! QuestionViewController
//            destination.questions = data[categoryIndex!].questions
//            destination.currentQuestionIndex = currentQuestionIndex! + 1
//            destination.categoryIndex = categoryIndex!
////        }
//    }

}
