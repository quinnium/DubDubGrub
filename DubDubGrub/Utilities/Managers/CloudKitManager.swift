//
//  CloudKitManager.swift
//  DubDubGrub
//
//  Created by Quinn on 17/07/2022.
//

import CloudKit

final class CloudKitManager {
    
    static let shared = CloudKitManager()
    
    private init() { }
    
    var userRecord: CKRecord?
    var profileRecordID: CKRecord.ID?
    let container = CKContainer.default()
    
    // OLD way below (before async/await)
    //    func getUserRecord() {
    //        // Get our UserRecordID from the container
    //        CKContainer.default().fetchUserRecordID { recordID, error in
    //
    //            guard let recordID = recordID, error == nil else {
    //                print(error!.localizedDescription)
    //                return
    //            }
    //
    //            // Get our User Record from the Public Database
    //            CKContainer.default().publicCloudDatabase.fetch(withRecordIDs: [recordID]) { result in
    //                switch result {
    //                case .success(let array):
    //                    guard let result = array[recordID] else { return }
    //                    switch result {
    //                    case .success(let record):
    //                        self.userRecord = record
    //                        if let profileReference = record["userProfile"] as? CKRecord.Reference {
    //                            self.profileRecordID = profileReference.recordID
    //                        }
    //                    case .failure(let error):
    //                        print(error.localizedDescription)
    //                        return
    //                    }
    //                case .failure(let error):
    //                    print(error.localizedDescription)
    //                    return
    //                }
    //            }
    //        }
    //    }
    
    
    func getUserRecord() async throws {
        let recordID = try await container.userRecordID()
        let record = try await container.publicCloudDatabase.record(for: recordID)
        userRecord = record
        
        if let profileReference = record["userProfile"] as? CKRecord.Reference {
            profileRecordID = profileReference.recordID
        }
    }
    
    
    func getLocations() async throws -> [DDGLocation] {
        let sortDescriptor      = NSSortDescriptor(key: DDGLocation.kName, ascending: true)
        let query               = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors   = [sortDescriptor]
        
        let (matchedResults, _) = try await container.publicCloudDatabase.records(matching: query)
        let records = matchedResults.compactMap { (_, result) in
            try? result.get()
        }
        return records.map(DDGLocation.init)
    }
    
    
    func getCheckedInProfiles(for locationID: CKRecord.ID) async throws -> [DDGProfile] {
        let reference   = CKRecord.Reference(recordID: locationID, action: .none)
        let predicate   = NSPredicate(format: "isCheckedIn == %@", reference)
        let query       = CKQuery(recordType: RecordType.profile, predicate: predicate)
        
        let (matchedResults, _) = try await container.publicCloudDatabase.records(matching: query)
        let records = matchedResults.compactMap { (_, result) in try? result.get() }
        return records.map(DDGProfile.init)
    }
    
    
    func getCheckedInProfilesDictionary() async throws -> [CKRecord.ID:[DDGProfile]] {
        
        let predicate = NSPredicate(format: "\(DDGProfile.kIsCheckedInNilCheck) == 1")
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        
        var checkedInProfiles = [CKRecord.ID : [DDGProfile]]()
        
        let (matchedResults, cursor) = try await container.publicCloudDatabase.records(matching: query)
        let records = matchedResults.compactMap { (_, result) in try? result.get() }
        
        for record in records {
            let profile = DDGProfile(record: record)
            guard let locationReference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference else { continue }
            checkedInProfiles[locationReference.recordID, default: []].append(profile)
        }
        
        guard let cursor = cursor else { return checkedInProfiles }
        
        do {
            return try await continueWithCheckedInProfilesDict(cursor: cursor, dictionary: checkedInProfiles)
        } catch {
            throw error
        }
    }
    
    
    private func continueWithCheckedInProfilesDict(cursor: CKQueryOperation.Cursor, dictionary: [CKRecord.ID : [DDGProfile]]) async throws -> [CKRecord.ID:[DDGProfile]] {
        
        var checkedInProfiles = dictionary
        
        let (matchedResults, cursor) = try await container.publicCloudDatabase.records(continuingMatchFrom: cursor)
        let records = matchedResults.compactMap { (_, result) in try? result.get() }
        
        for record in records {
            let profile = DDGProfile(record: record)
            guard let locationReference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference else { continue }
            checkedInProfiles[locationReference.recordID, default: []].append(profile)
        }
        
        guard let cursor = cursor else { return checkedInProfiles }
        
        do {
            return try await continueWithCheckedInProfilesDict(cursor: cursor, dictionary: checkedInProfiles)
        } catch {
            throw error
        }
    }
    
     
    func getCheckedInProfilesCount() async throws -> [CKRecord.ID: Int] {
        let predicate           = NSPredicate(format: "\(DDGProfile.kIsCheckedInNilCheck) == 1")
        let query               = CKQuery(recordType: RecordType.profile, predicate: predicate)
        
        var checkedInProfiles   = [CKRecord.ID : Int]()
        
        let (matchedResults, _) = try await container.publicCloudDatabase.records(matching: query, desiredKeys: [DDGProfile.kIsCheckedIn])
        let records = matchedResults.compactMap { (_, result) in try? result.get() }
        
        for record in records {
            guard let locationReference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference else { continue }
            if let count = checkedInProfiles[locationReference.recordID] {
                checkedInProfiles[locationReference.recordID] = count + 1
            } else {
                checkedInProfiles[locationReference.recordID] = 1
            }
        }
        return checkedInProfiles
    }
    
    
    func batchSave(records: [CKRecord]) async throws -> [CKRecord] {
        let (savedResults, _) = try await container.publicCloudDatabase.modifyRecords(saving: records, deleting: [])
        return savedResults.compactMap { (_, result) in try? result.get() }
    }
    
    
    func save(record: CKRecord) async throws -> CKRecord {
        return try await container.publicCloudDatabase.save(record)
    }
    
    
    func fetchRecord(with id: CKRecord.ID) async throws -> CKRecord {
        return try await container.publicCloudDatabase.record(for: id)
    }
}
