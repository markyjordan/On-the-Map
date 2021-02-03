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
    @IBOutlet weak var refreshList: UIBarButtonItem!
    @IBOutlet weak var addLocation: UIBarButtonItem!
    
    var activityIndicatorView: UIActivityIndicatorView!
    var students = [StudentLocation]()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  setup activity indicator view
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.bringSubviewToFront(self.view)
        activityIndicatorView.center = self.view.center
    }
    
    
    // MARK: - User Interface
    
    @IBAction func logout(_ sender: Any) {
        //  set activity indicator view
        
        UdacityClient.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                
                //  hide activity indicator animation
            }
        }
        
    }
    
    @IBAction func refreshListData(_ sender: Any) {
        //  include activity indicator animation
        
        UdacityClient.getStudentLocations { (students, error) in
            self.students = students
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                //  hide activity indicator animation
            }
        }
        
    }
    
    // MARK: - Helpers
    
//    func showActivityIndicator() {
//        activityIndicatorView.isHidden = false
//        activityIndicatorView.startAnimating()
//    }
//
//    func hideActivityIndicator() {
//        activityIndicatorView.stopAnimating()
//        activityIndicatorView.isHidden = true
//    }
    
    //  set activity indicator view state
    func setActivityIndicator(_ fetchingData: Bool) {
        if fetchingData {
            DispatchQueue.main.async {
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        }
        
        //  enable/disable UI views
        DispatchQueue.main.async {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath)
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
