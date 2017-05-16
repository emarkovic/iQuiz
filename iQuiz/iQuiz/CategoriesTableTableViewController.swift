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
    var url = "http://tednewardsandbox.site44.com/questions.json"
    
    var quizData = [String: Category]()
    var quizDataIndex: [String] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.quizData = getAllData()
        print(self.quizData)
        print(self.quizData.count)
        if self.quizData.count == 0 {
            getDataFromUrl(url: self.url)
            self.quizData = getAllData()
        }
        for (key, _) in self.quizData {
            self.quizDataIndex.append(key)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iQuiz"
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
            
            extractJsonAndSave(json: data)
        }
        task.resume()
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "SettingsView") as! SettingsViewController
        
        popoverContent.modalPresentationStyle = .popover
//        var popover = popoverContent?.popoverPresentationController
        if let popover = popoverContent.popoverPresentationController {
            let viewForSource = sender as! UIView
            popover.sourceView = viewForSource
            
            popover.sourceRect = viewForSource.bounds
            
        }

        popoverContent.url = self.url
        self.present(popoverContent, animated: true, completion: nil)
        
//        let refreshAlert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
//        
//        
//        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//                    refreshAlert.dismiss(animated: true, completion: nil)
//                }))
//        
//        present(refreshAlert, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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
        return self.quizData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let title = self.quizDataIndex[indexPath.row]
        let item = self.quizData[title]
        
        cell.textLabel?.text = item?.title
        cell.detailTextLabel?.text = item?.subtitle
        cell.imageView?.image = item?.image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let rowClicked = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: rowClicked!)
        let currentCellTitle = currentCell!.textLabel?.text
        
        print(currentCellTitle!)
        
        if segue.identifier == "ToQuiz" {
            let destination = segue.destination as! QuestionViewController
            
            destination.quizData = self.quizData
            destination.categoryClicked = currentCellTitle
            destination.currentQuestionIndex = 0
            destination.numCorrect = 0
        }
    }
 

}
