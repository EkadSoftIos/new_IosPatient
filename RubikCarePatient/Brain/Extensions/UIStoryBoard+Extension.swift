//
//  6.swift
//  TYOUT
//
//  Created by Mohamed Lotfy on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import Foundation
import UIKit

enum storyBoardName: String {
    case Main = "Main"
    case Authentication = "Authentication"


}

enum storyBoardVCIDs: String {
    
    case IntroVC = "IntroVC"
    
}



extension UIStoryboard {
    class func instantiateInitialViewController(_ board: storyBoardName) -> UIViewController {
        let story = UIStoryboard(name: board.rawValue, bundle: nil)
        return story.instantiateInitialViewController()!
    }
}
