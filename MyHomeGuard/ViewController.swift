//
//  ViewController.swift
//  MyHomeGuard
//
//  Created by YIDING on 5/10/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var myString=String()
    var imgurl=String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageLabel.text=myString
        
        // Do any additional setup after loading the view.
        let url = URL(string:imgurl)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                print("fuck")
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

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let imageUrlString = "http://swiftdeveloperblog.com/wp-content/uploads/2015/07/1.jpeg"
//        let imageUrl:URL = URL(string: imageUrlString)!
//
//        // Start background thread so that image loading does not make app unresponsive
//        DispatchQueue.global(qos: .userInitiated).async {
//
//            let imageData:NSData = NSData(contentsOf: imageUrl)!
//
//            // When from background thread, UI needs to be updated on main_queue
//            DispatchQueue.main.async {
//                let image = UIImage(data: imageData as Data)
//                self.imageView.image = image
//
//            }
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

