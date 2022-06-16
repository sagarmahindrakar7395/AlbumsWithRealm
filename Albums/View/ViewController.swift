//
//  ViewController.swift
//  Albums
//
//  Created by Sagar Mahindrakar on 26/05/22.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var photoTableView: UITableView!
    
    var viewModel = AlbumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.dataSource = self
        photoTableView.delegate = self
        photoTableView.separatorStyle = .none
        photoTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        
        viewModel.getDataFromLocalDatabase()
        viewModel.getAlbums()
            
        }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 30))
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = viewModel.albums[section].title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        cell.photos = viewModel.photos[indexPath.item]
            cell.loadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}




