//
//  VIPERConfig.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import UIKit

open class CleanArchitectureLayer {}

public protocol ViewLayer: AnyObject {}
public protocol InteractorToPresenter: AnyObject {}

open class Presenter: CleanArchitectureLayer {
    public weak var _view: ViewLayer?
    
    public override init() {
        super.init()
    }
}

open class Interactor: CleanArchitectureLayer {
    public var _presenter: Presenter?
    public var _router: Router?
    
    public override init() {
        super.init()
    }
}

open class Router: CleanArchitectureLayer {
    public weak var _view: UIViewController?
    
    public override init() {
        super.init()
    }
}

extension UIViewController: ViewLayer {
    fileprivate static var computedProperty = [String: CleanArchitectureLayer]()
    
    var _interactor: Interactor {
        get {
            let address = String(format: "%p", unsafeBitCast(self, to: Int.self)) + "Interactor"
            return UIViewController.computedProperty[address] as! Interactor
        }
        
        set(newValue) {
            let address = String(format: "%p", unsafeBitCast(self, to: Int.self)) + "Interactor"
            UIViewController.computedProperty[address] = newValue
        }
    }
    
    func setup(interactor: Interactor? = nil, router: Router? = nil, presenter: Presenter? = nil) {
        if let i = interactor, let r = router, let p = presenter {
            p._view = self
            r._view = self
            i._presenter = p
            i._router = r
            self._interactor = i
        }
    }
}
