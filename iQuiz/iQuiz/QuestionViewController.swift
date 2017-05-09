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
    var currentQuest = 0;
    var previousBtnPressed: UIButton?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var b0: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    override func viewDidLoad() {
        let curQuestion = questions![currentQuest]
        super.viewDidLoad()
        questionLabel.text = curQuestion.question
        print(curQuestion.answers)
        
        b0.setTitle(curQuestion.answers[0], for: .normal)
        b1.setTitle(curQuestion.answers[1], for: .normal)
        b2.setTitle(curQuestion.answers[2], for: .normal)
        b3.setTitle(curQuestion.answers[3], for: .normal)
    }

    @IBAction func b0Pressed(_ sender: Any) {
        clearPreviousPressed()
        
        b0.layer.borderWidth = 1
        previousBtnPressed = b0
    }
    
    @IBAction func b1Pressed(_ sender: Any) {
        clearPreviousPressed()
        
        b1.layer.borderWidth = 1
        previousBtnPressed = b1
    }
    
    @IBAction func b2Pressed(_ sender: Any) {
        clearPreviousPressed()
        
        b2.layer.borderWidth = 1
        previousBtnPressed = b2
    }
    
    @IBAction func b3Pressed(_ sender: Any) {
        clearPreviousPressed()
        
        b3.layer.borderWidth = 1
        previousBtnPressed = b3
    }
    
    func clearPreviousPressed() {
        if previousBtnPressed != nil {
            previousBtnPressed!.layer.borderWidth = 0;
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
