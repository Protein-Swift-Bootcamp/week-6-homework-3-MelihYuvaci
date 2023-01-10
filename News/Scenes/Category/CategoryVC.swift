//
//  ViewController.swift
//  News
//
//  Created by Melih Yuvacı on 10.01.2023.
//

import UIKit

class CategoryVC: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    let categoriesArray = ["all","national","business","sports","world","politics","techology","politics","startup","entertainment","miscellaneous","hatke","science","automobile"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }
    
  
    

}

//MARK: - TableViewDataSource

extension CategoryVC :UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell",for: indexPath) as! CategoryCell
        cell.label.text = categoriesArray[indexPath.row]
        return cell
    }
    
}

//MARK: - TableViewDelegate

extension CategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FeedVC") as? FeedVC{
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

