//
//  EpisodeListItem.swift
//  UITableViewDemo
//
//  Created by 宋小伟 on 2022/10/1.
//

import Foundation

class EpisodeListItem : NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encodeConditionalObject(title, forKey: "Title")
        coder.encodeConditionalObject(finished, forKey: "Finished")
    }
    
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "Title") as! String
        finished = coder.decodeObject(forKey: "Finished") as! Bool
        
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    var title = ""
    var finished = false
    
    
}
