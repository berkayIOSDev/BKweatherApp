//
//  ViewController.swift
//  BKweatherApp
//
//  Created by Berkay on 26.06.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var onaltiTempLabel: UILabel!
    @IBOutlet weak var besTempLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    let api = "ceeca35e593e9a14a445dff93e50379d"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getButtonClicked(_ sender: Any) {
        
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=41.633539&lon=26.623781&appid=ceeca35e593e9a14a445dff93e50379d")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            
            if error != nil  {
                print("error")
            } else{
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as?[String:Any]
                        
                        DispatchQueue.main.async {
                            if let main = jsonResponse!["main"] as? [String:Any] {
                                if let temp = main["temp"] as? Double{
                                    self.currentTempLabel.text = String(Int(temp-272.15))
                                }
                                if let feels = main["feels_like"] as? Double{
                                    self.besTempLabel.text = String(Int(feels-272.15))
                                }
                            
                            }
                            if let wind = jsonResponse!["wind"] as? [String:Any]{
                                if let speed = wind["speed"] as? Double{
                                    self.onaltiTempLabel.text = String(Int(speed))
                                }
                            }
                        }
                        
                    } catch{
                        
                    }
                }
            }
            
        }
        task.resume()
        
    }
    
}

