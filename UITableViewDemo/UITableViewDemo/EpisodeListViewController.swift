//
//  ViewController.swift
//  UITableViewDemo
//
//  Created by 宋小伟 on 2022/10/1.
//

import UIKit

class EpisodeListViewController: UITableViewController {
    var episodeListItems: [EpisodeListItem] = []
    
    func getEpisodeListItemData() {
        for i in 1...10 {
            let e = EpisodeListItem()
            e.title = "Episode \(i)"
            e.finished = i % 2 == 0 ? true : false
            
            episodeListItems.append(e)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeItem", for: indexPath)
        let label = cell.viewWithTag(1024) as! UILabel
        let title = self.episodeListItems[indexPath.row].title
        label.text = title
        cell.accessoryType = self.episodeListItems[indexPath.row].finished ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func documentDirectory() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return urls[0]
    }
    
    func fileUrl(fileName: String) -> URL {
        let documentUrl = self.documentDirectory().appending(component: fileName)
        return documentUrl
    }
    
    func saveEpisodeListItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver.init(forWritingWith: data)
        archiver.encode(episodeListItems, forKey: "episodeListItems")
        archiver.finishEncoding()
        
        let plistUrl = fileUrl(fileName: "EpisodeList.plist")
        data.write(to: plistUrl, atomically: true)
    }
    
    func loadEpisodeListItems() {
        let plistUrl = fileUrl(fileName: "EpisodeList.plist")
        
//        if (try? plistUrl.checkResourceIsReachable()) != nil
//        {
//            if let data = NSMutableData(contentsOf: plistUrl){
//                let unarchiver = NSKeyedUnarchiver.init(forReadingWith: data as Data)
//                episodeListItems = unarchiver.decodeObject(forKey: "episodeListItems") as! [EpisodeListItem]
//                unarchiver.finishDecoding()
//            }
//
//        }
//        else{
            getEpisodeListItemData()
            saveEpisodeListItems()
        //}
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadEpisodeListItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let documentsDirUrl = documentDirectory()
        let plistUrl = fileUrl(fileName: "EpisodeList.plist")
        
        print("Docouments dir url: \(documentsDirUrl)")
        print("Plist file url: \(plistUrl)")
    }


}

