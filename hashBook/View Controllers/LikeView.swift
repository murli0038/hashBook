//
//  LikeView.swift
//  hashBook
//
//  Created by Nikunj Prajapati on 01/02/20.
//  Copyright © 2020 Nikunj Prajapati. All rights reserved.
//

import UIKit
import CoreData

class LikeView: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    
    var managedContextObject:NSManagedObjectContext!
         //model data: table's row
         var managedObject:NSManagedObject!
         //list
         var list:[NSManagedObject]!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LikeTableViewCell

         
        cell.liketagname.text = "\(self.list[indexPath.row].value(forKey: "likedtag")!)"
         // Configure the cell...
        
         return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle==UITableViewCell.EditingStyle.delete
        {
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
                context.delete(self.list[indexPath.row])
                
                do
                {
                    try context.save()
                    self.list.removeAll()
                    self.listData()
                    self.tableview.reloadData()
                }
                catch
                {
                    print("error")
                }
                
            }
            else{
                print("Something wrong")
            }
    }
    
    func listData()
    {
        let fetchReq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Like")
        
        do{
            self.list = try self.managedContextObject.fetch(fetchReq) as! [NSManagedObject]
            for item in self.list
            {
                
            }
        }
        catch
        {
            print("Error in fetch")
        }
        tableview.reloadData()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Liked Tags❤️"
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        self.managedContextObject = appDel.persistentContainer.viewContext
        
        listData()
        tableview.reloadData()
        animateTable()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backgroundImage.bounds
        backgroundImage.addSubview(blurView)
        
        
        // Do any additional setup after loading the view.
    }
    
    func animateTable() {
           tableview.reloadData()
           let cells = tableview.visibleCells
           
           let tableViewHeight = tableview.bounds.size.height
           
           for cell in cells {
               cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
           }
           
           var delayCounter = 0
           for cell in cells {
               UIView.animate(withDuration: 2.0, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                   cell.transform = CGAffineTransform.identity
               }, completion: nil)
               delayCounter += 1
           }
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           animateTable()
       }
       
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
