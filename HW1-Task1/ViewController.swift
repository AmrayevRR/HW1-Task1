//
//  ViewController.swift
//  HW1-Task1
//
//  Created by Ramir Amrayev on 4/11/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let getGroceriesLabel = PaddingLabel()
    let dayStackView = UIStackView()
    let dayLabel = PaddingLabel()
    let daySwitch = UISwitch()
    let dateLabel = PaddingLabel()
    let datePicker = UIDatePicker()
    let repeatStackView = UIStackView()
    let repeatLabel = PaddingLabel()
    let neverLabel = PaddingLabel()
    let arrowImageView = UIImageView()
    let locationStack = UIStackView()
    let locationLabel = PaddingLabel()
    let locationSwitch = UISwitch()
    let priorityStack = UIStackView()
    let priorityLabel = PaddingLabel()
    let noteStack = UIStackView()
    let noteLabel = PaddingLabel()
    let noteTextField = UITextField()
    
    var spacing = 40.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layoutUI()
        
        // Do any additional setup after loading the view.
    }

    private func layoutUI() {
        
        spacing = Double(view.frame.size.height * 0.05)
        
        layoutNavigationBar()
        
        view.addSubview(scrollView)
        layoutScrollView()
        
        scrollView.addSubview(getGroceriesLabel)
        scrollView.addSubview(dayStackView)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(datePicker)
        scrollView.addSubview(repeatStackView)
        scrollView.addSubview(locationStack)
        scrollView.addSubview(priorityStack)
        scrollView.addSubview(noteStack)
        
        layoutGetGroceriesLabel()
        layoutDayStackView()
        layoutDatePicker()
        layoutDateLabel()
        layoutRepeatStackView()
        layoutLocationStack()
        layoutPriorityStack()
        layoutNoteStack()
    }
    
    private func layoutScrollView() {
        
        scrollView.backgroundColor = .secondarySystemBackground
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(view.safeAreaInsets)
            $0.trailing.equalTo(view.safeAreaInsets)
        }
    }
    
    private func layoutNavigationBar() {
        title = "Create reminder"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(leftBarButtonAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(rightBarButtonAction))
    }
    
    private func layoutGetGroceriesLabel() {
        getGroceriesLabel.text = "Get groceries"
        getGroceriesLabel.backgroundColor = .white
        
        getGroceriesLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(spacing)
            $0.height.equalTo(50)
            $0.width.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func layoutDayStackView() {
        dayStackView.axis = .horizontal
        
        dayStackView.backgroundColor = .white
        dayStackView.addSubview(dayLabel)
        dayStackView.addSubview(daySwitch)
        
        dayStackView.snp.makeConstraints{
            $0.leading.equalTo(getGroceriesLabel)
            $0.top.equalTo(getGroceriesLabel.snp.bottom).offset(spacing)
            $0.size.equalTo(getGroceriesLabel)
        }
        
        layoutPaddingLabelInHStack(paddingLabel: dayLabel, text: "Remind me on a day", widthRatio: 0.7)
        layoutSwitchInHStack(stackSwitch: daySwitch, isOn: true, action: #selector(daySwitchValueDidChange))
    }
    
    private func layoutSwitchInHStack(stackSwitch: UISwitch, isOn: Bool, action: Selector) {
        stackSwitch.setOn(isOn, animated: true)
        stackSwitch.addTarget(self, action: action, for: .valueChanged)
        
        stackSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func layoutDatePicker() {
        datePicker.backgroundColor = .white
        
        // Set some of UIDatePicker properties
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        
        // Set style
        datePicker.preferredDatePickerStyle = .wheels
        
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        datePickerValueChanged(sender: datePicker)
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.width.equalTo(getGroceriesLabel)
        }
    }
    
    private func layoutDateLabel() {
        dateLabel.textColor = .link
        dateLabel.backgroundColor = .white
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dayStackView.snp.bottom)
            $0.leading.equalTo(getGroceriesLabel)
            $0.size.equalTo(getGroceriesLabel)
        }
        
        // Add gray line above label
//        let grayLine = UIView()
//
//        view.addSubview(grayLine)
//
//        grayLine.backgroundColor = .gray
//        grayLine.snp.makeConstraints {
//            $0.bottom.equalTo(dateLabel.snp.top)
//            $0.leading.equalToSuperview()
//        }
    }
    
    private func layoutRepeatStackView() {
        repeatStackView.axis = .horizontal
        
        repeatStackView.backgroundColor = .white
        
        repeatStackView.addSubview(repeatLabel)
        repeatStackView.addSubview(neverLabel)
        repeatStackView.addSubview(arrowImageView)
        
        repeatStackView.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom)
            $0.size.equalTo(getGroceriesLabel)
            $0.leading.equalTo(getGroceriesLabel)
        }
        
        layoutPaddingLabelInHStack(paddingLabel: repeatLabel, text: "Repeat", widthRatio: 0.7)
        layoutArrowImageView()
        layoutNeverLabel()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleRepeatStackTap))
        repeatStackView.addGestureRecognizer(tap)
    }
    
    private func layoutPaddingLabelInHStack (paddingLabel: PaddingLabel, text: String, widthRatio: Float) {
        paddingLabel.text = text
        
        paddingLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(widthRatio)
            $0.height.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
    
    private func layoutArrowImageView() {
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .gray
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func layoutNeverLabel() {
        neverLabel.text = "Never"
        neverLabel.textColor = .gray
        neverLabel.rightInset = 8
        
        neverLabel.snp.makeConstraints {
            $0.trailing.equalTo(arrowImageView.snp.leading)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func layoutLocationStack() {
        locationStack.axis = .horizontal
        
        locationStack.backgroundColor = .white
        locationStack.addSubview(locationLabel)
        locationStack.addSubview(locationSwitch)
        
        locationStack.snp.makeConstraints{
            $0.leading.equalTo(getGroceriesLabel)
            $0.top.equalTo(repeatStackView.snp.bottom).offset(spacing)
            $0.size.equalTo(getGroceriesLabel)
        }
        
        layoutPaddingLabelInHStack(paddingLabel: locationLabel, text: "Remind me at a location", widthRatio: 0.7)
        layoutSwitchInHStack(stackSwitch: locationSwitch, isOn: false, action: #selector(locationSwitchValueDidChange))
    }
    
    private func layoutPriorityStack() {
        priorityStack.axis = .horizontal
        
        // Initialize
        let items = ["None", "!", "!!", "!!!"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        
        // Style the Segmented Control
        segmentedControl.layer.cornerRadius = 5.0  // Don't let background bleed
        
        priorityStack.backgroundColor = .white
        priorityStack.addSubview(priorityLabel)
        priorityStack.addSubview(segmentedControl)
        
        priorityStack.snp.makeConstraints{
            $0.leading.equalTo(getGroceriesLabel)
            $0.top.equalTo(locationStack.snp.bottom).offset(spacing)
            $0.size.equalTo(getGroceriesLabel)
        }
        
        layoutPaddingLabelInHStack(paddingLabel: priorityLabel, text: "Priority", widthRatio: 0.4)
        
        segmentedControl.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        
        // Add target action method
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    private func layoutNoteStack() {
        noteStack.axis = .vertical
        
        noteStack.backgroundColor = .white
        noteStack.addSubview(noteLabel)
        noteStack.addSubview(noteTextField)
        
        noteStack.snp.makeConstraints{
            $0.leading.equalTo(getGroceriesLabel)
            $0.top.equalTo(priorityStack.snp.bottom)
            $0.width.equalTo(getGroceriesLabel)
            $0.height.equalTo(getGroceriesLabel).multipliedBy(1.7)
        }
        
        layoutNoteLabel()
        layoutNoteTextField()
    }
    
    private func layoutNoteLabel() {
        noteLabel.text = "Notes"
        
        noteLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    private func layoutNoteTextField() {
        noteTextField.snp.makeConstraints {
            $0.top.equalTo(noteLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func leftBarButtonAction(sender: UINavigationItem!) {
        print("Cancel button clicked")
    }
    @objc func rightBarButtonAction(sender: UINavigationItem!) {
        print("Done button clicked")
    }
    @objc func daySwitchValueDidChange(sender: UISwitch!) {
        if (sender.isOn){
            print("Day switch is on")
        }
        else{
            print("Day switch is off")
        }
    }
    @objc func locationSwitchValueDidChange(sender: UISwitch!) {
        if (sender.isOn){
            print("Location switch is on")
        }
        else{
            print("Location switch is off")
        }
    }
    @objc func datePickerValueChanged(sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = " E, MMM d, yyyy, hh:mm aa"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        dateLabel.text = selectedDate
        print("Selected date \(selectedDate)")
    }
    @objc func handleRepeatStackTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("Repeat stack clicked")
    }
    @objc func segmentedControlValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            print("!")
        case 2:
            print("!!")
        case 3:
            print("!!!")
        default:
            print("None")
        }
    }
}

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 15.0
    @IBInspectable var rightInset: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}

