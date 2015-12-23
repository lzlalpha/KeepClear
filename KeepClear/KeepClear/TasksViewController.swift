//
//  ViewController.swift
//  KeepClear
//
//  Created by lzlalpha on 15/12/21.
//  Copyright © 2015年 lzlalpha. All rights reserved.
//

import UIKit
import RealmSwift

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks : Results<Task>?
    var selectedTask : Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // 取得数据
        let realm = try! Realm()
        tasks = realm.objects(Task)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 转移界面前，设置数据
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetailSegue") {
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.currTask = selectedTask
        }
        
    }
    
    // 点击添加任务转移到详细界面
    @IBAction func addTask(sender: AnyObject) {
        selectedTask = nil
        performSegueWithIdentifier("showDetailSegue", sender: nil)
    }
    
    
    @IBAction func unwind(unwindSegue : UIStoryboardSegue) {
        let vc = unwindSegue.sourceViewController as! DetailViewController
        let realm = try! Realm()
        
        if vc.currTask == nil { // 新增
            let task = Task()
            task.title = vc.titleText.text!
            task.memo = vc.memoText.text!
            
            try! realm.write({ () -> Void in
                realm.add(task)
            })
        } else { // 更新
            try! realm.write({ () -> Void in
                vc.currTask?.title = vc.titleText.text!
                vc.currTask?.memo = vc.memoText.text!
                
            })
        }

        tasks = realm.objects(Task)
        tableView.reloadData()
    }

}

extension TasksViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // 设置表格行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks!.count
    }
    // 设置单元格聂荣
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let titleText = cell.viewWithTag(100) as! UILabel
        let memoText = cell.viewWithTag(200) as! UILabel
        
        titleText.text = tasks![indexPath.row].title
        memoText.text = tasks![indexPath.row].memo
              
        return cell
    }
    // 设置条目高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    // 选择某一个条目转移到详细界面
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTask = tasks![indexPath.row]
        performSegueWithIdentifier("showDetailSegue", sender: indexPath)
    }
    
}

