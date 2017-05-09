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
    var userAnswer: Int?
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
