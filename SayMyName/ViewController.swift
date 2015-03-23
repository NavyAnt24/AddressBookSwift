//
//  ViewController.swift
//  SayMyName
//
//  Created by David Attarzadeh on 3/21/15.
//  Copyright (c) 2015 DavidAttarzadeh. All rights reserved.
//

import UIKit
import AddressBookUI

class ViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate {
    @IBOutlet weak var forenameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    
    @IBAction func getContact(sender: AnyObject) {
        if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Denied || ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Restricted) {
            println("Denied")
        } else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized) {
            self.showPeoplePicker()
        } else { // undetermined
            var emptyDictionary: CFDictionaryRef?
            var addressBook: ABAddressBookRef?
            println("Requesting access...")
            
            addressBook = obtainAddressbook(ABAddressBookCreateWithOptions(emptyDictionary, nil))
            ABAddressBookRequestAccessWithCompletion(addressBook, {
                success, error in
                if success {
                    self.showPeoplePicker()
                } else {
                    println("Denied")
                }
            })
        }
    }
    
    @IBAction func sayContact(sender: AnyObject) {
        var personName = String(format: NSLocalizedString("SELECTED", comment: "Selected person"), forenameField.text, surnameField.text)
        TextToSpeech.SayText(personName)
        
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!) {
        if let forename = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as? String {
            forenameField.text = forename
        }
        
        if let surname = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as? String {
            surnameField.text = surname
        }
    }
    
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController!) {
        println("Cancelled!")
    }
    
    func showPeoplePicker() {
        var picker: ABPeoplePickerNavigationController = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func obtainAddressbook(addressBookRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        if let addressBook = addressBookRef {
            return Unmanaged<NSObject>.fromOpaque(addressBook.toOpaque()).takeUnretainedValue()
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

