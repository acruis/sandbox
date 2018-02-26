import CoreData

/*:
 # Setting up the stack
 
 a) Define the MOM.
 */

let personNameAttribute = NSAttributeDescription()
personNameAttribute.name = "name"
personNameAttribute.attributeType = .stringAttributeType
personNameAttribute.isOptional = false

let personStatusAttribute = NSAttributeDescription()
personStatusAttribute.name = "status"
personStatusAttribute.attributeType = .stringAttributeType
personStatusAttribute.isOptional = true

let person = NSEntityDescription()
person.name = "Person"
person.properties = [personNameAttribute, personStatusAttribute]

let model = NSManagedObjectModel()
model.entities = [person]

//: b) Create a PSC.

let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
let storeURL = docURL?.appendingPathComponent("store")
// Delete existing store first to avoid inconsistencies.
let fm = FileManager()
if fm.fileExists(atPath: storeURL!.path) {
    try! fm.removeItem(at: storeURL!)
}
try! psc.addPersistentStore(ofType: NSBinaryStoreType, configurationName: nil, at: storeURL, options: nil)

//: c) Create a MOC.

let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
moc.persistentStoreCoordinator = psc

/*:
 # Use the stack
 
 a) Create object in PSC.
 */

let p1 = NSEntityDescription.insertNewObject(forEntityName: "Person", into: moc)
p1.setValue("Yuuri", forKeyPath: "name")
p1.setValue("Napping", forKeyPath: "status")
try! moc.save()

//: b) Pull object from PSC.

let fr = NSFetchRequest<NSManagedObject>(entityName: "Person")
let predicate = NSPredicate(format: "%K == %@", "name", "Yuuri")
fr.predicate = predicate
let p2 = try! moc.fetch(fr).first!
print(p2.value(forKey: "name")!) // Yuuri

//: c) Edit object but don't save to PSC.

p2.setValue("Chito", forKeyPath: "name")

//: d) Pull again.

let yuuri = try! moc.fetch(fr)
print(yuuri.isEmpty) // true

//: e) Pull by another attribute.

let frStatus = NSFetchRequest<NSManagedObject>(entityName: "Person")
let predicateStatus = NSPredicate(format: "%K == %@", "status", "Napping")
frStatus.predicate = predicateStatus
let napper = try! moc.fetch(frStatus).first!
print(napper.value(forKey: "name")!) // Chito
