//
//  ListTableViewVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/7/20.
//

import UIKit

class ListTableViewVC: UITableViewController {

    //  MARK: - Outlets/Properties
    
    @IBOutlet weak var studentListTableView: UITableView!
    @IBOutlet weak var refreshList: UIBarButtonItem!
    @IBOutlet weak var addLocation: UIBarButtonItem!
    
    var activityIndicatorView: UIActivityIndicatorView!
    var studentLocationData = [StudentLocation]()
    
    
    //  MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  setup activity indicator view
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.bringSubviewToFront(self.view)
        activityIndicatorView.center = self.view.center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getListData()
    }
    
    
    //  MARK: - Navigation
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        setActivityIndicator(true)
        
        UdacityNetworkClient.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                self.setActivityIndicator(false)
            }
        }
    }
    
    
    //  MARK: - User Interface
    
    @IBAction func refreshListData(_ sender: Any) {
        setActivityIndicator(true)
        
        UdacityNetworkClient.getStudentLocations { (students, error) in
            self.studentLocationData = students
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.setActivityIndicator(false)
            }
        }
    }
    
    
    //  MARK: - Helpers
    
    //  retrieve data from the server and subsequently update the UI
    private func getListData() {
        setActivityIndicator(true)
        
        UdacityNetworkClient.getStudentLocations { (students, error) in
            self.studentLocationData = students
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.setActivityIndicator(false)
            }
        }
    }
    
    //  set activity indicator view state
    private func setActivityIndicator(_ fetchingData: Bool) {
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
            self.refreshList.isEnabled = !fetchingData
            self.addLocation.isEnabled = !fetchingData
        }
    }

    
    //  MARK: - Table View Delegate and Data Source Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentLocationData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath)
        let student = studentLocationData[indexPath.row]
        cell.textLabel!.text = "\(student.firstName)" + " " + "\(student.lastName)"
        cell.detailTextLabel!.text = "\(student.mediaURL)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = studentLocationData[indexPath.row]
        openURL(student.mediaURL)
    }
}
