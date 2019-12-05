//
//  LandmarkRemarkListCell.swift
//  LandmarkRemark
//
//  Created by Parth on 05/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

class LandmarkRemarkListCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let style = Style.landmarkRemark
        style.apply(textStyle: .title, to: self.textLabel!)
        style.apply(textStyle: .subtitle, to: self.detailTextLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
