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
    var previousButton: UIButton?
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions![currentQuest].question
        // Do any additional setup after loading the view.
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
