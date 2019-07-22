//
//  WorkoutRunController.swift
//  MiniChallenge2
//
//  Created by Michael Louis on 22/07/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import UIKit

class WorkoutRunController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var WorkoutRunTableViewCell: UIStackView!
    @IBOutlet weak var nameRunLabel: UILabel!
    @IBOutlet weak var countRunLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let runCell = tableView.dequeueReusableCell(withIdentifier: "runCell", for: indexPath) as! WorkoutTableViewCell
//
//        nameRunLabel.text =
//
        return runCell
    }
    
}
