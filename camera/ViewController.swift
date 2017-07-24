//
//  ViewController.swift
//  camera
//
//  Created by Rplay on 22/05/2017.
//  Copyright © 2017 Rplay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cameraPreview: CameraPreview!

    @IBOutlet weak var menuTableView: MenuTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
