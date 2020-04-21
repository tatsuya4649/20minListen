//
//  EnglishListCell.swift
//  20minListen
//
//  Created by 下川達也 on 2020/04/18.
//  Copyright © 2020 下川達也. All rights reserved.
//

import UIKit
import FontAwesome_swift
import AVFoundation

class EnglishListCell: UITableViewCell {
    
    var label : UILabel!
    var timer : UILabel!
    var offsetY : CGFloat!
    var correctLabel : UILabel!
    var repeatButton : UIButton!
    var talker : AVSpeechSynthesizer!
    var repeatButtonAnimation : CABasicAnimation!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    public func setUp(_ width:CGFloat,_ english:String,_ time:String,_ correct:SelectAction){
        offsetY = CGFloat(0)
        timer = UILabel()
        let remainingTime = getTime(time)
        timer.text = time
        timer.font = .systemFont(ofSize: 12, weight: .light)
        timer.textColor = .gray
        timer.sizeToFit()
        timer.center = CGPoint(x: 10 + timer.frame.size.width/2, y: 5 + timer.frame.size.height/2)
        self.contentView.addSubview(timer)
        correctLabel = UILabel()
        correctLabel.text = correct.rawValue
        correctLabel.font = .systemFont(ofSize: 10, weight: .bold)
        switch correct {
        case .correct:
            correctLabel.textColor = .blue
        case .incorrect:
            correctLabel.textColor = .red
        case .notAnswered:
            correctLabel.textColor = .lightGray
        default:
            break
        }
        correctLabel.sizeToFit()
        correctLabel.center = CGPoint(x: 5 + correctLabel.frame.size.width/2, y: timer.frame.maxY + 5 + correctLabel.frame.size.height/2)
        self.contentView.addSubview(correctLabel)
        repeatButton = UIButton()
        repeatButton.setTitle(String.fontAwesomeIcon(name: .volumeUp), for: .normal)
        repeatButton.setTitleColor(.white, for: .normal)
        repeatButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 15, style: .solid)
        repeatButton.sizeToFit()
        repeatButton.titleLabel?.sizeToFit()
        repeatButton.titleLabel?.textAlignment = .center
        repeatButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        repeatButton.backgroundColor = .black
        repeatButton.layer.cornerRadius = repeatButton.frame.size.height/2
        repeatButton.addTarget(self, action: #selector(clickRepeat), for: .touchUpInside)
        repeatButton.center = CGPoint(x:width - 30 - repeatButton.frame.size.width/2,y:self.contentView.frame.size.height/2)
        self.contentView.addSubview(repeatButton)
        offsetY += 5 + timer.frame.size.height
        offsetY += 5 + correctLabel.frame.size.height
        label = UILabel()
        label.text = english
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.textColor = .black
        let rect = label.sizeThatFits(CGSize(width: 0.8*(repeatButton.frame.minX), height: CGFloat.greatestFiniteMagnitude))
        label.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        label.center = CGPoint(x: (repeatButton.frame.minX)/2, y: offsetY + 20 + label.frame.size.height/2)
        repeatButton.center = CGPoint(x:width - 30 - repeatButton.frame.size.width/2,y:label.center.y)
        print(width)
        offsetY += max(correctLabel.frame.maxY,label.frame.maxY,repeatButton.frame.maxY)
        self.contentView.addSubview(label)
    }
    
    private func getTime(_ time:String)->String{
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let date = formatter.date(from: time){
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            let second = calendar.component(.second, from: date)
            let dateFrom = calendar.date(from: DateComponents(calendar: calendar, timeZone: TimeZone.init(identifier: "ja_JP"), era: nil, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil))!
            let dateTo = calendar.date(from: DateComponents(year: 2011, month: 7, day: 11))!
        }
        return time
    }
    class func returnHeight(_ width:CGFloat,_ english:String,_ time:String,_ correct:SelectAction)->CGFloat{
        var  heightOffsetY = CGFloat()
        let heightTimer = UILabel()
        heightTimer.text = time
        heightTimer.font = .systemFont(ofSize: 12, weight: .light)
        heightTimer.textColor = .gray
        heightTimer.sizeToFit()
        heightTimer.center = CGPoint(x: 10 + heightTimer.frame.size.width/2, y: 5 + heightTimer.frame.size.height/2)
        let heightCorrectLabel = UILabel()
        heightCorrectLabel.text = correct.rawValue
        heightCorrectLabel.font = .systemFont(ofSize: 10, weight: .bold)
        heightCorrectLabel.textColor = .red
        heightCorrectLabel.sizeToFit()
        heightCorrectLabel.center = CGPoint(x: 5 + heightCorrectLabel.frame.size.width/2, y: heightTimer.frame.maxY + 5 + heightCorrectLabel.frame.size.height/2)
        heightOffsetY += 5 + heightTimer.frame.size.height
        heightOffsetY += 5 + heightCorrectLabel.frame.size.height
        let heightRepeatButton = UIButton()
        heightRepeatButton.setTitle(String.fontAwesomeIcon(name: .volumeUp), for: .normal)
        heightRepeatButton.setTitleColor(.white, for: .normal)
        heightRepeatButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
        heightRepeatButton.sizeToFit()
        heightRepeatButton.titleLabel?.sizeToFit()
        heightRepeatButton.titleLabel?.textAlignment = .center
        heightRepeatButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        heightRepeatButton.backgroundColor = .black
        heightRepeatButton.layer.cornerRadius = heightRepeatButton.frame.size.height/2
        heightRepeatButton.center = CGPoint(x:width - 30 - heightRepeatButton.frame.size.width/2,y:heightRepeatButton.frame.size.height/2)
        let heightLabel = UILabel()
        heightLabel.text = english
        heightLabel.font = .systemFont(ofSize: 15, weight: .regular)
        heightLabel.numberOfLines = 0
        heightLabel.lineBreakMode = .byCharWrapping
        heightLabel.textColor = .black
        let rect = heightLabel.sizeThatFits(CGSize(width: 0.8*(heightRepeatButton.frame.minX), height: CGFloat.greatestFiniteMagnitude))
        heightLabel.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        heightLabel.center = CGPoint(x: (heightRepeatButton.frame.minX)/2, y: heightOffsetY + 20 + heightLabel.frame.size.height/2)
        heightOffsetY += max(heightCorrectLabel.frame.maxY,heightLabel.frame.maxY)
        return heightOffsetY
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        print(self.frame)
    }
    
}
