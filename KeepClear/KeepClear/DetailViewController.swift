//
//  DetailViewController.swift
//  KeepClear
//
//  Created by lzlalpha on 15/12/21.
//  Copyright © 2015年 lzlalpha. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UITableViewController {

    var currTask : Task?
    
    @IBOutlet weak var memoText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = currTask {
            titleText.text = currTask!.title
            memoText.text = currTask!.memo
        } else {
            titleText.text = ""
            memoText.text = ""
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 模糊图片
    func imageViewBlur( imageView : UIImageView) {
        imageView.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        imageView.insertSubview(blurEffectView, atIndex: 0)
    }

}
