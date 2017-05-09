//
//  MyPresentaionController.swift
//  MyTabbedApplication
//
//  Created by sen.ke on 2017/5/8.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

class MyPresentaionController: UIPresentationController {

    override func presentationTransitionWillBegin() {
        print(#function)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        print(#function)
    }
    
    override func dismissalTransitionWillBegin() {
        print(#function)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        print(#function)
    }
    
}
