//
//  ListTableViewVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/7/20.
//

import UIKit

class ListTableViewVC: UITableViewController {

    // MARK: - Outlets/Properties
    
    @IBOutlet weak var studentListTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var students = [StudentLocation]()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - User Interface
    
    @IBAction func logout(_ sender: Any) {
        // include activity indicator animation
        
        UdacityClient.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                
                // hide activity indicator animation
            }
        }
        
    }
    
    @IBAction func refreshListData(_ sender: Any) {
        // include activity indicator animation
        
        UdacityClient.getStudentLocations { (students, error) in
            self.students = students
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                // hide activity indicator animation
            }
        }
        
    }

    
    // MARK: - Table View Delegate and Data Source Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath)
        let student = students[indexPath.row]
        cell.textLabel?.text = "\(student.firstName)" + " " + "\(student.lastName)"
        cell.detailTextLabel?.text = "\(student.mediaURL ?? "")"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = students[indexPath.row]
        openURL(student.mediaURL ?? "")
    }
}
