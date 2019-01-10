//
//  ViewController.swift
//  BilibiliGuiChuRanking2
//
//  Created by J K on 2019/1/9.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var nextView: NextViewController?

    var tableView: UITableView!
    
    var videoImageUrl = [String]()
    var videoIDs = [String]()
    var videoTitles = [String]()
    var videoAuthors = [String]()
    var videoPlays = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.7658459821, blue: 0.7677842445, alpha: 1)
        
        nextView = NextViewController()
        
        //标题
        self.navigationItem.title = "B站鬼畜排行"
        
        //更新按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(ViewController.refresh))
        
        //更新按钮颜色
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2925564509, green: 0.5599889934, blue: 1, alpha: 1)
        
        //标题颜色
        let attrib = Dictionary(dictionaryLiteral: (NSAttributedString.Key.foregroundColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        self.navigationController?.navigationBar.titleTextAttributes = attrib
        
        //导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9996750951, green: 0.6848248839, blue: 0.788582623, alpha: 1)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: self.view.frame.height))
        tableView.backgroundColor = #colorLiteral(red: 1, green: 0.7658459821, blue: 0.7677842445, alpha: 1)
        tableView.center.x = self.view.center.x
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    //数据更新
    @objc func refresh() {
        jsonInfo()
        //短暂延迟后执行更新tableView
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            self.tableView.reloadData()
        }
    }
    
    //=================================================================
    
    //json解析
    func jsonInfo() {
        //如果数据库里有之前的数据，就删除
        self.deleteData()
        //api链接
        let url = URL(string: "https://api.bilibili.com/x/web-interface/ranking/region?callback=jqueryCallback_bili_6351362506911729&rid=119&day=3")
        
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
        
                    let theData = jsonData["data"] as! [AnyObject]
                    
                    for i in 0 ..< theData.count {
                        //视频id
                        let videoID = theData[i]["aid"] as? String ?? " "
                        
                        //视频标题
                        let videoTitle = theData[i]["title"] as? String ?? " "
                        
                        //UP主
                        let theAuthor = theData[i]["author"] as? String ?? " "
                        
                        //视频封面图
                        let videoImagePath = theData[i]["pic"] as! String
                        
                        //播放数
                        let videoPlay = theData[i]["play"] as? Double ?? 0.0
                        
                        DispatchQueue.main.async {
                            //存入数据库
                            self.savesData(videoID, videoTitle, theAuthor, videoImagePath, videoPlay)
                            
                            if (i + 1) == theData.count {
                                self.loadData()
                            }
                        }
                    }
                }catch {
                    print("json数据获取失败")
                }
                
            }else {
                print("请求失败")
            }
        }
        dataTask.resume()
    }
    
    //删除数据库
    func deleteData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managed = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managed)
        
        let request = NSFetchRequest<User>(entityName: "User")
        request.fetchOffset = 0
        request.entity = entity
        request.predicate = nil
        
        do {
            let results: [AnyObject] = try managed.fetch(request)
            for i in results as! [User] {
                managed.delete(i)
            }
            try managed.save()
            if self.videoIDs != nil {
                self.videoIDs = []
                self.videoPlays = []
                self.videoTitles = []
                self.videoAuthors = []
                self.videoImageUrl = []
            }
            print("删除完成")
        }catch {
            print("删除失败")
        }
    }
    
    //保存至数据库
    func savesData(_ id: String, _ title: String, _ author: String, _ imgPath: String, _ videoPlay: Double) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managed = appDelegate.persistentContainer.viewContext
        
        let newObj = NSEntityDescription.insertNewObject(forEntityName: "User", into: managed) as! User
        newObj.aid = id
        newObj.videoTitle = title
        newObj.author = author
        newObj.videoImage = imgPath
        newObj.play = videoPlay
        
        do {
            try managed.save()
            print("保存数据成功!")
        }catch {
            print("保存数据失败...")
        }
    }
    
    //读取数据
    func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managed = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managed)
        
        let request = NSFetchRequest<User>(entityName: "User")
        request.fetchOffset = 0
        request.entity = entity
        request.predicate = nil
        
        do {
            let results: [AnyObject]? = try managed.fetch(request)
            for i in results as! [User] {
                self.videoImageUrl.append(i.videoImage!)
                self.videoIDs.append(i.aid!)
                self.videoTitles.append(i.videoTitle!)
                self.videoPlays.append(i.play)
                self.videoAuthors.append(i.author!)
            }
        }catch {
            print("读取失败")
        }
    }
    
    //=================================================================
    
    //cell行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    //cell数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "reusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? TableViewCell
        if cell == nil {
            cell = TableViewCell(style: .default, reuseIdentifier: id)
        }
        
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if let imgPath: String = self.videoImageUrl[indexPath.row] {
            
            let url = URL(string: imgPath)
            do {
                let data = try Data(contentsOf: url!)
                cell!.imgView?.image = UIImage(data: data)
    
            }catch {
                print("img数据错误")
            }
            cell!.authorLabel.text = "UP: \(self.videoAuthors[indexPath.row])"
            cell!.videoTitle.text = self.videoTitles[indexPath.row]
            cell!.videoPlays.text = "播放量: \(Int(self.videoPlays[indexPath.row]))"
            cell!.rankView.text = "\(indexPath.row + 1)"
        }
        
        return cell!
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nextView!.path = self.videoIDs[indexPath.row]
        self.navigationController?.pushViewController(nextView!, animated: true)
        print(self.videoIDs[indexPath.row])
        
    }
    
}

