//
//  NewTag.swift
//  hashBook
//
//  Created by Nikunj Prajapati on 15/02/20.
//  Copyright © 2020 Nikunj Prajapati. All rights reserved.
//

import UIKit
import CoreData

class newTagCell : UITableViewCell
{
    
    @IBOutlet weak var newTagName: UILabel!
    
    @IBOutlet weak var copyToClipboard: UIButton!
    
    @IBOutlet weak var newTagEdit: UIButton!
    
    @IBAction func CopyClipBoard(_ sender: Any)
    {
        UIPasteboard.general.string = newTagName.text
        print("Tag Copied :\(newTagName.text!)")
    }
    
}

class NewTag: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var name:[NSManagedObject] = []
    
    var people:[NSManagedObject] = []
    
    var EditCore : [NSManagedObject] = []
    
    var managedObj:NSManagedObject!
    
    var manageContext:NSManagedObjectContext!
    
    var managedObjList:[NSManagedObject]!
    
    var manage2Context:NSManagedObjectContext!
    
    
    // MARK: - TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "newTag", for: indexPath) as? newTagCell
        cell?.newTagName.text = person.value(forKey: "newTag") as? String
        
//        cell?.newTagEdit.tag = indexPath.row
//        cell?.newTagEdit.addTarget(self, action: #selector(self.newTageditTapped(_:)), for: .touchUpInside)
        return cell!
    }
    
    @objc func newTageditTapped(_ sender: UIButton) {
        
        let editor = self.storyboard?.instantiateViewController(withIdentifier: "NewTagEdit") as! NewTagEdit
        
        editor.EditCore = [people[sender.tag]]
        //print(editor.EditCore)
        
        self.navigationController?.pushViewController(editor, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle==UITableViewCell.EditingStyle.delete
        {
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            context.delete(self.people[indexPath.row])
            
            do
            {
                try context.save()
                self.people.removeAll()
                self.ReadData()
                self.tableView.reloadData()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add button
    @IBAction func addNewTagPressed(_ sender: Any)
    {
        let alert = UIAlertController(title: "Feel Your Tag", message: "Take your #Tag", preferredStyle: .alert)
        
        let add = UIAlertAction(title: "Add", style: .default, handler:saveTag(alert:))
        alert.addTextField(configurationHandler: UserTx(textField:))
        alert.addAction(add)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    var UserTxt = UITextField()
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func UserTx(textField: UITextField)
    {
        UserTxt = textField
        UserTxt.text = "#"
        UserTxt.placeholder = "Enter #tag"
    }
    func saveTag(alert : UIAlertAction )
    {
        //save the tag
        self.save(name: UserTxt.text!)
        tableView.reloadData()
    }
    
    
    // MARK: -Read data from Coredata
    func ReadData()
    {
        self.managedObjList = [NSManagedObject]()
        
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Person")
        
        do
        {
            // managedObjList = try manageContext.fetch(fetchReq)
            self.viewWillAppear(true)
        }
        catch let err as NSError
        {
            print(err.localizedDescription)
        }
    }
    // MARK: - Save Fuction For Coredata
    func save(name: String)
    {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
            else
        {
            return
        }
        let manageContext = appdelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: manageContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: manageContext)
        
        person.setValue(name, forKey: "newTag")
        
        do
        {
            try manageContext.save()
            people.append(person)
            print("Data successfully saved")
        }
        catch let error as NSError
        {
            print("Failed to Save the Data \(error),\(error.userInfo)")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backgroundImg.bounds
        backgroundImg.addSubview(blurView)
        animateTable()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //these steps are to show the as usual data which we are added
        //step 1
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
            else
        {
            return
        }
        
        let manageContext = appdelegate.persistentContainer.viewContext
        
        //step 2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //step 3
        do
        {
            people = try manageContext.fetch(fetchRequest)
        }
        catch let error as NSError
        {
            print("Data is not Saved \(error),\(error.userInfo)")
        }
        tableView.reloadData()
        animateTable()
    }
    
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.size.height
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
