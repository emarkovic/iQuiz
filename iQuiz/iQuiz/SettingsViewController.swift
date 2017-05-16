//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Personal on 5/16/17.
//  Copyright © 2017 Ena Markovic. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var url:String?
    
    @IBAction func fetchNewDataPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func reFetchDataPressed(_ sender: Any) {
        if url != nil {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func closePessed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
