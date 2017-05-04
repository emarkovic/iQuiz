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
    var questions: [String]
    var image: UIImage
    
    init(title: String, subtitle: String, questions: [String], imageName: String) {
        self.title = title
        self.subtitle = subtitle
        self.questions = questions
        self.image = UIImage(named: imageName)!
    }
}

