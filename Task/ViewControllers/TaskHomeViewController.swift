//
//  TaskHomeViewController.swift
//  Task
//
//  Created by Armaghan  on 4/19/21.
//

import UIKit

class TaskHomeViewController: UIViewController
{

    @IBOutlet weak var tblHomeImages: UITableView!
        
    var reuseIdentifier = "cellTaskHome"
    var arrImagesURLs : [String]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.viewSetup()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- View Setup
    func viewSetup()
    {
        self.tblHomeImages.delegate = self
        self.tblHomeImages.dataSource = self
        let nibCell = UINib(nibName: "TaskHomeTableViewCell", bundle: nil)
        self.tblHomeImages.register(nibCell, forCellReuseIdentifier: reuseIdentifier)
        self.tblHomeImages.tableFooterView = UIView()
        self.arrImagesURLs = [Constants.IMAGEURLONE, Constants.IMAGEURLTWO, Constants.IMAGEURLTHREE]
        self.tblHomeImages.reloadData()
    }

}
//MARK:- Table View Delegates and Data Source
extension TaskHomeViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrImagesURLs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblHomeImages.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TaskHomeTableViewCell
        cell.populateCells(imgURL: URL(string: self.arrImagesURLs![indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200.0
    }
}
