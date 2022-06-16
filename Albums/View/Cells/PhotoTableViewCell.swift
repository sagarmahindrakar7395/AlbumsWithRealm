//
//  PhotoTableViewCell.swift
//  Albums
//
//  Created by Sagar Mahindrakar on 27/05/22.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    
    var photos = [Photo]()

    @IBOutlet weak var photoCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        self.photoCollectionView.register(UINib(nibName:"PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")

    
    }
    
    func loadData(){
        photoCollectionView.reloadData()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PhotoTableViewCell: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let urlS = photos[indexPath.item].url
        let url = URL(string: urlS)
        cell.imageView.sd_setImage(with: url, placeholderImage:UIImage())

            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
           //return CGSize(width: 100.0, height: 50.0)
            let noOfCellsInRow = 3   //number of column you want
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size, height: size)

        }
    
    }

