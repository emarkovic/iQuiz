//
//  CategoriesTableTableViewController.swift
//  iQuiz
//
//  Created by Personal on 5/4/17.
//  Copyright © 2017 Ena Markovic. All rights reserved.
//

import UIKit
import CoreData

class CategoriesTableTableViewController: UITableViewController {
    @IBAction func settingsPressed(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    refreshAlert.dismiss(animated: true, completion: nil)
                }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iQuiz"

//        var data = getAllData()
//        print(data.count)
//        self.deleteAllData()
        var data = getAllData()
        print(data.count)
        
        if data.count == 0 {
            getDataFromUrl(url: "http://tednewardsandbox.site44.com/questions.json")
        }
        
        data = getAllData()
        print(data.count)
    }
    
    func getDataFromUrl(url: String) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: url)
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("data is empty")
                return
            }
            
            self.extractJsonAndSave(json: data)
        }
        task.resume()
    }
    
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
                self.getAllData()
            }
        }
    }
    
    func getAllData() -> [Any] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let catQuest = try context.fetch(Category_Question.fetchRequest())
            return catQuest
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let item = data[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        cell.imageView?.image = item.image
        print(cell)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let rowClicked = tableView.indexPathForSelectedRow?.row
        if segue.identifier == "ToQuiz" {
            let destination = segue.destination as! QuestionViewController
            // row clicked targets the correct category
            destination.categoryIndex = rowClicked!
            destination.questions = data[rowClicked!].questions
            destination.currentQuestionIndex = 0
            destination.numCorrect = 0
        }
    }
 

}
