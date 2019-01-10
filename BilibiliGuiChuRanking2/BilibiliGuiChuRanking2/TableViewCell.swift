//
//  TableViewCell.swift
//  BilibiliGuiChuRanking2
//
//  Created by J K on 2019/1/9.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var imgView: UIImageView?
    var vieww: UIView!
    var authorLabel: UILabel!
    var videoTitle: UILabel!
    var videoPlays: UILabel!
    var rankView: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = #colorLiteral(red: 1, green: 0.7658459821, blue: 0.7677842445, alpha: 1)
        
        rankView = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        rankView.layer.cornerRadius = 15
        rankView.layer.masksToBounds = true
        rankView.backgroundColor = UIColor.white
        rankView.textAlignment = NSTextAlignment.center
        rankView.textColor = #colorLiteral(red: 1, green: 0.4317408278, blue: 0.4798942456, alpha: 1)
        rankView.font = UIFont.boldSystemFont(ofSize: 15)
        
        vieww = UIView(frame: CGRect(x: 0, y: 0, width: 260, height: 160))
        vieww.center.x = self.center.x
        vieww.center.y = 110
        vieww.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        vieww.layer.shadowColor = UIColor.black.cgColor
        vieww.layer.shadowOffset = CGSize(width: 3, height: 3)
        vieww.layer.shadowRadius = 6
        vieww.layer.shadowOpacity = 0.5
        vieww.clipsToBounds = false
        
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 260, height: 120))
        imgView?.contentMode = UIView.ContentMode.scaleAspectFill
        imgView?.clipsToBounds = true
        
        authorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        authorLabel.center = CGPoint(x: vieww.frame.width - 40, y: vieww.frame.height - 10)
        authorLabel.font = UIFont(name: "Arial", size: 10)
        authorLabel.textColor = #colorLiteral(red: 1, green: 0.4317408278, blue: 0.4798942456, alpha: 1)
        authorLabel.textAlignment = NSTextAlignment.center
        authorLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        videoTitle = UILabel(frame: CGRect(x: 0, y: 0, width: vieww.frame.width - 20, height: 40))
        videoTitle.center = CGPoint(x: vieww.frame.width/2, y: vieww.frame.height - 30)
        videoTitle.font = UIFont.boldSystemFont(ofSize: 10)
        videoTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        videoTitle.textAlignment = NSTextAlignment.center
        videoTitle.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        videoPlays = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        videoPlays.center = CGPoint(x: vieww.frame.origin.x + 10, y: vieww.frame.height - 10)
        videoPlays.font = UIFont(name: "Arial", size: 10)
        videoPlays.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        videoPlays.textAlignment = NSTextAlignment.center
        
        vieww.addSubview(videoPlays)
        vieww.addSubview(videoTitle)
        vieww.addSubview(imgView!)
        vieww.addSubview(authorLabel)
        vieww.addSubview(rankView)
        self.addSubview(vieww)
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
