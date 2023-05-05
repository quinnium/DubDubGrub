//
//  MockData.swift
//  DubDubGrub
//
//  Created by AQ on 15/07/2022.
//

import CloudKit

struct MockData {
    
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kName]           = "KitKat's bar & Grill"
        record[DDGLocation.kAddress]        = "29 Almost Thirty Street, Sevenoaks, Kent"
        record[DDGLocation.kDescription]    = "Tastiest meals, served by the tastiest chef. For an interesting twist, try asking for some 'sweet hot tart' for desert."
        record[DDGLocation.kLocation]       = CLLocation(latitude: 37.331516, longitude: -121.891054)
        record[DDGLocation.kPhoneNumber]    = "0345 363 3630"
        record[DDGLocation.kWebsiteURL]     = "http://www.quinnium.com"
        
        return record
    }
    
    
    static var chipotle: CKRecord {
        let record                          = CKRecord(recordType: RecordType.location,
                                                       recordID: CKRecord.ID(recordName: "2BC7A894-384A-C330-1018-40B70C1979DF"))
        record[DDGLocation.kName]           = "Chipotle"
        record[DDGLocation.kAddress]        = "1 S Market St Ste 40"
        record[DDGLocation.kDescription]    = "Our local San Jose One South Market Chipotle Mexican Grill is cultivating a better world by serving responsibly sourced, classically-cooked, real food."
        record[DDGLocation.kWebsiteURL]     = "https://locations.chipotle.com/ca/san-jose/1-s-market-st"
        record[DDGLocation.kLocation]       = CLLocation(latitude: 37.334967, longitude: -121.892566)
        record[DDGLocation.kPhoneNumber]    = "408-938-0919"
        
        return record
    }
    
    
    static var profile: CKRecord {
        let record = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName]   = "Test"
        record[DDGProfile.kLastName]    = "user"
        record[DDGProfile.kCompanyName] = "Best comapny ever"
        record[DDGProfile.kBio]         = "This is my bio, i hope it isn't too long as i can't check charatcer count"
        
        return record
    }

}
