//
//  ViewController.swift
//  NotificationDemo
//
//  Created by Ankita Thakur on 30/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    var currentNotificationView: NotificationCustomView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCustomNotificationAlert("Message", "Hi there! I've been struggling with dating lately and thought I could use some help.", UIImage(named: "heart-attack"))
        // Do any additional setup after loading the view.
    }
    func showCustomNotificationAlert(_ title : String?, _ message : String?,_ image: UIImage?) {
        if let currentView = currentNotificationView {
               currentView.removeFromSuperview()
           }
           
           // Load the custom notification view from the XIB file
           let notificationView: NotificationCustomView = Bundle.loadView(fromNib: "NotificationCustomView", withType: NotificationCustomView.self)
          
        notificationView.frame = CGRect(x: 20, y: -100, width: self.view.frame.width - 40, height: 100)
        notificationView.lblTitle.text = title
        notificationView.lblText.text = message
        notificationView.imgView.image = image
//
        self.view.addSubview(notificationView)
        currentNotificationView = notificationView
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            notificationView.frame.origin.y = 50
        }) { (completed) in
            notificationView.startDismissalTimer()
        }
    }


    @IBAction func actionPop(_ sender : UIButton){
        showCustomNotificationAlert("Message", "Hi there! I've been struggling with dating lately and thought I could use some help.", UIImage(named: "heart-attack"))
    }

}

extension Bundle {
    
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        
        fatalError("Could not load view with type " + String(describing: type))
    }
    
}
