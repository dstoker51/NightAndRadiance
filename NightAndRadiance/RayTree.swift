//
//  Tree.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/27/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class RayNode: CustomStringConvertible {
    var ray: Ray
    var children: Set<RayNode> = []
    var depth = 0
    weak var parent: RayNode?
    var description: String {
        var text = "\(ray)"
        
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
    
    init(ray: Ray) {
        self.ray = ray
        
    }
    
    func add(child: RayNode) {
        children.insert(child)
        child.parent = self
        child.depth = depth + 1
    }
    
    func remove(child: RayNode) {
        children.remove(child)
    }
    
    func nodeFor(ray: Ray) -> RayNode? {
        if ray == self.ray {
            return self
        }
        
        for child in children {
            if let found = child.nodeFor(ray: ray) {
                return found
            }
        }
        return nil
    }
}

extension RayNode: Hashable {
    static func == (lhs: RayNode, rhs: RayNode) -> Bool {
        return lhs.ray == rhs.ray && lhs.children == rhs.children
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ray)
        hasher.combine(children)
    }
}
