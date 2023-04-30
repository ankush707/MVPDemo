//
//  ViewController.swift
//  MVPDemo
//
//  Created by Ankush on 20/03/23.
//

import UIKit

class ViewController: UIViewController {

    lazy var tableView : UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50), style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .cyan
        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    
    private var viewModel = ViewModel(request: APIRequest())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .cyan
        self.view.addSubview(tableView)
        viewModel.fetchData()
        
        viewModel.homeObj.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
       
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.homeObj.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        if let currentObject = viewModel.homeObj.value?[indexPath.row] {
            cell.textLabel?.text = "\(currentObject.dataObj.nation) has population of \(currentObject.dataObj.population) in year \(currentObject.dataObj.year)."
            cell.textLabel?.numberOfLines = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
