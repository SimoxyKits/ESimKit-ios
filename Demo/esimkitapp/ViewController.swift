import UIKit
import ESimKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let str1 = NSLocalizedString("esimkit_sentences_small_1", comment: "Are you planning to go abroad?")
        let str2 = NSLocalizedString("esimkit_sentences_small_2", comment: "Get your eSIM now!")
        
        self.label1.text = str1
        self.label2.text = str2
    }
    
    
    @IBAction func btnAction(_ sender: UIButton) {
        ESimKitManager.shared.presentESimVC(on: self)
        
        //or embed
        //ESimKitManager.shared.embedESimVC(on: self, navigationController: self.navigationController)
    }
}
