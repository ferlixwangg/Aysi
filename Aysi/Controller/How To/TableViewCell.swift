//
//  TableViewCell.swift
//  ContainDetail
//
//  Created by Ivan Riyanto on 27/08/18.
//  Copyright © 2018 Ivan Riyanto. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var keteranganCollectionView: UIImageView!
    @IBOutlet weak var kontenCollectionView: UICollectionView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TableViewCell{
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDelegate & UICollectionViewDataSource>
        (_ dataSourceDelegate: D, forRow row:Int){
            kontenCollectionView.delegate = dataSourceDelegate
            kontenCollectionView.dataSource = dataSourceDelegate
        
            kontenCollectionView.reloadData()
    }
}
