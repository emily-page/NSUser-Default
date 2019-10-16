//
//  ViewController.swift
//  NSUser Default
//
//  Created by apcs2 on 8/30/17.
//  Copyright © 2017 apcs2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var notebook : Array<Dictionary<String, String>>?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadAssignments()
    }
    
    func saveAssignments()
    {
        defaults.set(notebook, forKey: "Assignments")
    }
    
    func loadAssignments()
    {
        notebook = defaults.array(forKey: "Assignments") as? Array ?? []
    }

    @IBAction func addAssignment(_ sender: UIStoryboardSegue)
    {
        let viewController = sender.source as? secondViewController
        notebook?.append(viewController?.getAssignment() ?? ["":""])
        saveAssignments()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return notebook!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notebook?[indexPath.row]["name"]
        cell.detailTextLabel?.text = notebook?[indexPath.row]["date"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            notebook?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveAssignments()
        }
    }
}
