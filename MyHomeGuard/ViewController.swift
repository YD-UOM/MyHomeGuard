//
//  ViewController.swift
//  MyHomeGuard
//
//  Created by YIDING on 5/10/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var myString=String()
    var imgurl=String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageLabel.text=myString
       // self.backgroundImage.image=UIImage(named:"home.jpg")
        // Do any additional setup after loading the view.
        
        let url = URL(string:imgurl)
        
        //Load the image from url
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                return
                
            }
            
            DispatchQueue.main.sync() {
                self.imageView.image = UIImage(data: data)
               
            }
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

