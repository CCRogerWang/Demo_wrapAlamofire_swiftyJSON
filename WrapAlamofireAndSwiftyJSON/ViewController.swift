//
//  ViewController.swift
//  WrapAlamofireAndSwiftyJSON
//
//  Created by roger on 2017/2/24.
//  Copyright © 2017年 roger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    
    @IBAction func callAPI(_ sender: Any) {
        Proxy.fetchAPI()
            .success{ (value) in
                print("value = \(value)")
                
            }
            .error{ (err) in
                print("err = \(err)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

