//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Personal on 5/9/17.
//  Copyright © 2017 Ena Markovic. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var questions: [Question]?
    var currentQuestionIndex: Int?
    var categoryIndex: Int?
    var numCorrect: Int?
    
    var currBtnPressed: UIButton?
    var answerIndex: Int?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var b0: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let curQuestion = questions![currentQuestionIndex!]                
        
        questionLabel.text = curQuestion.question
        
        b0.setTitle(curQuestion.answers[0], for: .normal)
        b1.setTitle(curQuestion.answers[1], for: .normal)
        b2.setTitle(curQuestion.answers[2], for: .normal)
        b3.setTitle(curQuestion.answers[3], for: .normal)
    }

    @IBAction func b0Pressed(_ sender: Any) {
        clearPreviousPressed()
        
        b0.layer.borderWidth = 1
        currBtnPressed = b0
        answerIndex = 0
    }
    
    @IBAction func b1Pressed(_ sender: Any) {
        clearPreviousPressed()
        
        b1.layer.borderWidth = 1
        currBtnPressed = b1
        answerIndex = 1
    }
    
    @IBAction func b2Pressed(_ sender: Any) {
        clearPreviousPressed()
        
        b2.layer.borderWidth = 1
        currBtnPressed = b2
        answerIndex = 2
    }
    
    @IBAction func b3Pressed(_ sender: Any) {
        clearPreviousPressed()
        
        b3.layer.borderWidth = 1
        currBtnPressed = b3
        answerIndex = 3
    }
    
    func clearPreviousPressed() {
        if currBtnPressed != nil {
            currBtnPressed!.layer.borderWidth = 0;
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToAnswer" {
            let destination = segue.destination as! AnswerViewController
            destination.question = questions![currentQuestionIndex!]
            destination.currentQuestionIndex = currentQuestionIndex!
            destination.categoryIndex = categoryIndex!
            destination.numCorrect = numCorrect!
            if answerIndex == nil {
                answerIndex = 0
            }
            destination.userAnswer = answerIndex            
        }
    }
    

}
