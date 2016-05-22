﻿#if NOUGAT

class DispatchGroup : DispatchObject {
	/*init() {
	}
	func wait(timeout: DispatchTime /*= default*/) -> Int {
	}
	func wait(walltime timeout: DispatchWalltime) -> Int {
	}
	func notify(queue: DispatchQueue, exeute block: () -> Void) {
	}
	func enter() {
	}
	func leave() {
	}*/
}

/*class DispatchIO : DispatchObject {
	enum StreamType : UInt {
		case stream
		case random
		typealias RawValue = UInt
		//var hashValue: Int { return U }
		/*init?(rawValue: UInt) {
			self.rawValue = rawValue
		}
		let rawValue: UInt*/
	}
	struct CloseFlags /*: OptionSet, RawRepresentable*/ {
		let rawValue: UInt
		init(rawValue: UInt) {
			self.rawValue = rawValue
		}
		static let stop: DispatchIO.CloseFlags
		typealias Element = DispatchIO.CloseFlags
		typealias RawValue = UInt
	}
	struct IntervalFlags /*: OptionSet, RawRepresentable*/ {
		let rawValue: UInt
		init(rawValue: UInt) {
		}
		static let strictInterval: DispatchIO.IntervalFlags
		typealias Element = DispatchIO.IntervalFlags
		typealias RawValue = UInt
	}
	class func read(fileDescriptor: Int32, length: Int, queue: DispatchQueue, handler: (DispatchData, Int32) -> Void) {
	}
	class func write(fileDescriptor: Int32, data: DispatchData, queue: DispatchQueue, handler: (DispatchData?, Int32) -> Void) {
	}
	convenience init(type: DispatchIO.StreamType, fileDescriptor: Int32, queue: DispatchQueue, cleanupHandler: (error: Int32) -> Void) {
	}
	convenience init(type: DispatchIO.StreamType, path: UnsafePointer<Int8>, oflag: Int32, mode: mode_t, queue: DispatchQueue, cleanupHandler: (error: Int32) -> Void) {
	}
	convenience init(type: DispatchIO.StreamType, io: DispatchIO, queue: DispatchQueue, cleanupHandler: (error: Int32) -> Void) {
	}
	func close(flags: DispatchIO.CloseFlags) {
	}
	var fileDescriptor: Int32 { get }
	func read(offset: off_t, length: Int, queue: DispatchQueue, ioHandler io_handler: (Bool, DispatchData?, Int32) -> Void) {
	}
	func setHighWater(highWater high_water: Int) {
	}
	func setInterval(interval: UInt64, flags: DispatchIO.IntervalFlags) {
	}
	func setLowWater(lowWater low_water: Int) {
	}
	func withBarrier(barrier: () -> Void) {
	}
	func write(offset: off_t, data: DispatchData, queue: DispatchQueue, ioHandler io_handler: (Bool, DispatchData?, Int32) -> Void) {
	}
}*/

class DispatchObject /*: OS_object*/ {
	func suspend() {
	}
	func resume() {
	}
	func setTargetQueue(queue: DispatchQueue?) {
	}
}

class DispatchQueue : DispatchObject {

	private let rawValue: dispatch_queue_t
	private init(rawValue: dispatch_queue_t) {
		self.rawValue = rawValue
	}

	enum GlobalAttributes /*: OptionSet*/ {
		case qosUserInteractive = DISPATCH_QUEUE_PRIORITY_BACKGROUND
		//case qosUserInitiated = DISPATCH_QUEUE_PRIORITY_BACKGROUND
		case qosDefault = DISPATCH_QUEUE_PRIORITY_DEFAULT
		//case qosUtility: DispatchQueue.GlobalAttributes
		case qosBackground = DISPATCH_QUEUE_PRIORITY_BACKGROUND
		//typealias Element = DispatchQueue.GlobalAttributes
		//typealias RawValue = UInt64
	}
	lazy class var main: DispatchQueue = DispatchQueue(rawValue: dispatch_get_main_queue())
	//class var main: DispatchQueue { get }
	class func global(attributes: DispatchQueue.GlobalAttributes) -> DispatchQueue {
		let raw = dispatch_get_global_queue(attributes.rawValue, 0)
		return DispatchQueue(rawValue: raw)
	}
	class func getSpecific<T>(key: DispatchSpecificKey<T>) -> T? {
	}
	convenience init(label: String, attributes: DispatchQueueAttributes /*= default*/, target: DispatchQueue? /*= default*/) {
		let raw = dispatch_queue_create(label.UTF8String, 0)
		init(rawValue: raw)
	}
	
	func after(when: DispatchTime, execute work: /*@convention(block)*/ () -> Void) {
		dispatch_after(when.rawValue, rawValue, work)
	}
	func after(walltime when: DispatchWalltime, execute work: /*@convention(block)*/ () -> Void) {
		//dispatch_after(when.rawValue, rawValue, work)
	}

	func apply(applier iterations: Int, execute block: @noescape (Int) -> Void) {
	}
	func asynchronously(execute workItem: DispatchWorkItem) {
	}
	func asynchronously(group: DispatchGroup? /*= default*/, qos: DispatchQoS /*= default*/, flags: DispatchWorkItemFlags /*= default*/, execute work: /*@convention(block)*/ () -> Void) {
		dispatch_async(rawValue, work)
	}
	var label: String {
		return NSString.stringWithUTF8String(dispatch_queue_get_label(rawValue))
	}
	
	func synchronously(execute block: @noescape () -> Void) {
		dispatch_sync(rawValue, block)
	}
	func synchronously(execute workItem: DispatchWorkItem) {
	}
	func synchronously<T>(execute work: @noescape () throws -> T) rethrows -> T {
		//dispatch_sync(rawValue, work) // E486 Parameter 2 is "block (_ ref error: NSError!) -> T<T>", should be "dispatch_block_t!", in call to rtl.dispatch_sync(_ queue: dispatch_queue_t!, _ block: dispatch_block_t!)
		var result: T
		dispatch_sync(rawValue) {
			//result = try! work() // E62 Type mismatch, cannot assign "T" to "T"
		}
		return result
	}
	func synchronously<T>(flags: DispatchWorkItemFlags, execute work: @noescape () throws -> T) rethrows -> T {
		var result: T
		dispatch_sync(rawValue) {
			//result = try! work() // E62 Type mismatch, cannot assign "T" to "T"
		}
		return result
	}
	
	/*var qos: DispatchQoS {
		var priority: Int
		//let qos = dispatch_queue_get_qos_class(rawValue, &priority) // E486 Parameter 2 is "Int", should be "UnsafePointer<Int32>", in call to rtl.dispatch_queue_get_qos_class(_ queue: dispatch_queue_t!, _ relative_priority_ptr: UnsafePointer<Int32>) -> qos_class_t
		//return DispatchQoS(qosClass: qos, relativePriority: priority)
	}*/
	func getSpecific<T>(key: DispatchSpecificKey<T>) -> T? {
		//return dispatch_queue_get_specific(rawValue, key)
	}
	func setSpecific<T>(key: DispatchSpecificKey<T>, value: T) {
		//return dispatch_queue_set_specific(rawValue, key, value)
	}
}

@noreturn func dispatchMain() {
}

/*class DispatchSemaphore : DispatchObject {
	init(value: Int) {
	}
	func wait(timeout: DispatchTime /*= default*/) -> Int {
	}
	func wait(walltime timeout: DispatchWalltime) -> Int {
	}
	func signal() -> Int {
	}
}*/

class DispatchSource : DispatchObject {
	struct MachSendEvent /*: OptionSet, RawRepresentable*/ {
		let rawValue: UInt
		init(rawValue: UInt) {
			self.rawValue = rawValue
		}
		//static let dead: DispatchSource.MachSendEvent// = MachSendEvent(rawValue: DISPATCH_SOURCE_TYPE_MACH_SEND())
		typealias Element = DispatchSource.MachSendEvent
		typealias RawValue = UInt
	}
	struct MemoryPressureEvent /*: OptionSet, RawRepresentable*/ {
		let rawValue: UInt
		init(rawValue: UInt) {
			self.rawValue = rawValue
		}
		//static let normal: DispatchSource.MemoryPressureEvent
		//static let warning: DispatchSource.MemoryPressureEvent
		//static let critical: DispatchSource.MemoryPressureEvent
		//static let all: DispatchSource.MemoryPressureEvent
		typealias Element = DispatchSource.MemoryPressureEvent
		typealias RawValue = UInt
	}
	struct ProcessEvent /*: OptionSet, RawRepresentable*/ {
		let rawValue: UInt
		init(rawValue: UInt) {
			self.rawValue = rawValue
		}
		//static let exit: DispatchSource.ProcessEvent
		//static let fork: DispatchSource.ProcessEvent
		//static let exec: DispatchSource.ProcessEvent
		//static let signal: DispatchSource.ProcessEvent
		//static let all: DispatchSource.ProcessEvent
		typealias Element = DispatchSource.ProcessEvent
		typealias RawValue = UInt
	}
	struct TimerFlags /*: OptionSet, RawRepresentable*/ {
		let rawValue: UInt
		init(rawValue: UInt) {
			self.rawValue = rawValue
		}
		//static let strict: DispatchSource.TimerFlags
		typealias Element = DispatchSource.TimerFlags
		typealias RawValue = UInt
	}
	struct FileSystemEvent /*: OptionSet, RawRepresentable*/ {
		let rawValue: UInt
		init(rawValue: UInt) {
			self.rawValue = rawValue
		}
		//static let delete: DispatchSource.FileSystemEvent
		//static let write: DispatchSource.FileSystemEvent
		//static let extend: DispatchSource.FileSystemEvent
		//static let attrib: DispatchSource.FileSystemEvent
		//static let link: DispatchSource.FileSystemEvent
		//static let rename: DispatchSource.FileSystemEvent
		//static let revoke: DispatchSource.FileSystemEvent
		//static let all: DispatchSource.FileSystemEvent
		typealias Element = DispatchSource.FileSystemEvent
		typealias RawValue = UInt
	}
/*	class func machSend(port: mach_port_t, eventMask: DispatchSource.MachSendEvent, queue: DispatchQueue? /*= default*/) -> DispatchSourceMachSend {
	}
	class func machReceive(port: mach_port_t, queue: DispatchQueue? /*= default*/) -> DispatchSourceMachReceive {
	}
	class func memoryPressure(eventMask: DispatchSource.MemoryPressureEvent, queue: DispatchQueue? /*= default*/) -> DispatchSourceMemoryPressure {
	}
	class func process(identifier: pid_t, eventMask: DispatchSource.ProcessEvent, queue: DispatchQueue? /*= default*/) -> DispatchSourceProcess {
	}
	class func read(fileDescriptor: Int32, queue: DispatchQueue? /*= default*/) -> DispatchSourceRead {
	}
	class func signal(signal: Int32, queue: DispatchQueue? /*= default*/) -> DispatchSourceSignal {
	}
	class func timer(flags: DispatchSource.TimerFlags /*= default*/, queue: DispatchQueue? /*= default*/) -> DispatchSourceTimer {
	}
	class func userDataAdd(queue: DispatchQueue? /*= default*/) -> DispatchSourceUserDataAdd {
	}
	class func userDataOr(queue: DispatchQueue? /*= default*/) -> DispatchSourceUserDataOr {
	}
	class func fileSystemObject(fileDescriptor: Int32, eventMask: DispatchSource.FileSystemEvent, queue: DispatchQueue? /*= default*/) -> DispatchSourceFileSystemObject {
	}
	class func write(fileDescriptor: Int32, queue: DispatchQueue? /*= default*/) -> DispatchSourceWrite {
	}
*/
}


protocol DispatchSourceType /*: NSObjectProtocol*/ {
	typealias DispatchSourceHandler = /*@convention(block)*/ () -> Void
	func setEventHandler(handler: DispatchSourceHandler?)
	func setCancelHandler(handler: DispatchSourceHandler?)
	func setRegistrationHandler(handler: DispatchSourceHandler?)
	func cancel()
	func resume()
	func suspend()
	var handle: UInt { get }
	var mask: UInt { get }
	var data: UInt { get }
	var isCancelled: Bool { get }
}
/*extension DispatchSource : DispatchSourceType {
}*/
protocol DispatchSourceUserDataAdd : DispatchSourceType {
	func mergeData(value: UInt)
}
/*extension DispatchSource : DispatchSourceUserDataAdd {
}*/
protocol DispatchSourceUserDataOr : DispatchSourceType {
	func mergeData(value: UInt)
}
/*extension DispatchSource : DispatchSourceUserDataOr {
}*/
protocol DispatchSourceMachSend : DispatchSourceType {
  var handle: mach_port_t { get }
  var data: DispatchSource.MachSendEvent { get }
  var mask: DispatchSource.MachSendEvent { get }
}
/*extension DispatchSource : DispatchSourceMachSend {
}*/
protocol DispatchSourceMachReceive : DispatchSourceType {
  var handle: mach_port_t { get }
}
/*extension DispatchSource : DispatchSourceMachReceive {
}*/
protocol DispatchSourceMemoryPressure : DispatchSourceType {
  var data: DispatchSource.MemoryPressureEvent { get }
  var mask: DispatchSource.MemoryPressureEvent { get }
}
/*extension DispatchSource : DispatchSourceMemoryPressure {
}*/
protocol DispatchSourceProcess : DispatchSourceType {
  var handle: pid_t { get }
  var data: DispatchSource.ProcessEvent { get }
  var mask: DispatchSource.ProcessEvent { get }
}
/*extension DispatchSource : DispatchSourceProcess {
}*/
protocol DispatchSourceRead : DispatchSourceType {
}
/*extension DispatchSource : DispatchSourceRead {
}*/
protocol DispatchSourceSignal : DispatchSourceType {
}
/*extension DispatchSource : DispatchSourceSignal {
}*/
protocol DispatchSourceTimer : DispatchSourceType {
  func setTimer(start: DispatchTime, leeway: DispatchTimeInterval /*= default*/)
  func setTimer(walltime start: DispatchWalltime, leeway: DispatchTimeInterval /*= default*/)
  func setTimer(start: DispatchTime, interval: DispatchTimeInterval, leeway: DispatchTimeInterval /*= default*/)
  func setTimer(start: DispatchTime, interval: Double, leeway: DispatchTimeInterval /*= default*/)
  func setTimer(walltime start: DispatchWalltime, interval: DispatchTimeInterval, leeway: DispatchTimeInterval /*= default*/)
  func setTimer(walltime start: DispatchWalltime, interval: Double, leeway: DispatchTimeInterval /*= default*/)
}
/*extension DispatchSource : DispatchSourceTimer {
}*/
protocol DispatchSourceFileSystemObject : DispatchSourceType {
  var handle: Int32 { get }
  var data: DispatchSource.FileSystemEvent { get }
  var mask: DispatchSource.FileSystemEvent { get }
}
/*extension DispatchSource : DispatchSourceFileSystemObject {
}*/
protocol DispatchSourceWrite : DispatchSourceType {
}
/*extension DispatchSource : DispatchSourceWrite {
}*/
extension DispatchSourceMemoryPressure {
  //var data: DispatchSource.MemoryPressureEvent { get }
  //var mask: DispatchSource.MemoryPressureEvent { get }
}
/*extension DispatchSourceMachReceive {
  var handle: mach_port_t { get }
}*/
extension DispatchSourceFileSystemObject {
  //var handle: Int32 { get }
  //var data: DispatchSource.FileSystemEvent { get }
  //var mask: DispatchSource.FileSystemEvent { get }
}
extension DispatchSourceUserDataOr {
  func mergeData(value: UInt) {
	}
}
struct DispatchData /*: RandomAccessCollection, _ObjectiveCBridgeable*/ {
	/*typealias Iterator = DispatchDataIterator
	typealias Index = Int
	typealias Indices = DefaultRandomAccessIndices<DispatchData>
	/*static*/ let empty: DispatchData // E492 Flag "static" not allowed on this member
	enum Deallocator {
		case free
		case unmap
		case custom(DispatchQueue?, /*@convention(block)*/ () -> Void)
	}
	init(bytes buffer: UnsafeBufferPointer<UInt8>) {
	}
	init(bytesNoCopy bytes: UnsafeBufferPointer<UInt8>, deallocator: DispatchData.Deallocator /*= default*/) {
	}
	var count: Int { get }
	func withUnsafeBytes<Result, ContentType>(body: @noescape (UnsafePointer<ContentType>) throws -> Result) rethrows -> Result {
	}
	//func enumerateBytes(block: @noescape (buffer: UnsafeBufferPointer<UInt8>, byteIndex: Int, stop: inout Bool) -> Void) { // E1 closing parenthesis expected, got identifier
	func enumerateBytes(block: @noescape (buffer: UnsafeBufferPointer<UInt8>, byteIndex: Int, inout stop: Bool) -> Void) {
	}
	mutating func append(_ bytes: UnsafePointer<UInt8>, count: Int) {
	}
	mutating func append(_ other: DispatchData) {
	}
	mutating func append<SourceType>(_ buffer: UnsafeBufferPointer<SourceType>) {
	}
	func copyBytes(to pointer: UnsafeMutablePointer<UInt8>, count: Int) {
	}
	func copyBytes(to pointer: UnsafeMutablePointer<UInt8>, from range: CountableRange<Index>) {
	}
	func copyBytes<DestinationType>(to buffer: UnsafeMutableBufferPointer<DestinationType>, from range: CountableRange<Index>? /*= default*/) -> Int {
	}
	subscript(index: Index) -> UInt8 { get }
	subscript(bounds: Range<Int>) -> RandomAccessSlice<DispatchData> { get }
	func subdata(in range: CountableRange<Index>) -> DispatchData {
	}
	func region(location: Int) -> (data: DispatchData, offset: Int) {
	}
	var startIndex: Index { get }
	var endIndex: Index { get }
	func index(before i: Index) -> Index {
	}
	func index(after i: Index) -> Index {
	}
	func makeIterator() -> Iterator {
	}
	typealias IndexDistance = Int
	typealias _Element = UInt8
	typealias SubSequence = RandomAccessSlice<DispatchData>
	typealias _ObjectiveCType = __DispatchData*/
}
struct DispatchDataIterator /*: IteratorProtocol, Sequence*/ {
	/*mutating func next() -> _Element? {
	}
	typealias Element = _Element
	typealias Iterator = DispatchDataIterator
	typealias SubSequence = AnySequence<_Element>*/
}
struct DispatchQoS /*: Equatable*/ {
	let qosClass: DispatchQoS.QoSClass
	let relativePriority: Int
	static let background: DispatchQoS	  = DispatchQoS(qosClass: QoSClass.background)
	static let utility: DispatchQoS		 = DispatchQoS(qosClass: QoSClass.utility)
	static let defaultQoS: DispatchQoS	  = DispatchQoS(qosClass: QoSClass.defaultQoS)
	static let userInitiated: DispatchQoS   = DispatchQoS(qosClass: QoSClass.userInitiated)
	static let userInteractive: DispatchQoS = DispatchQoS(qosClass: QoSClass.userInteractive)
	static let unspecified: DispatchQoS	 = DispatchQoS(qosClass: QoSClass.unspecified)
	enum QoSClass {
		case background
		case utility
		case defaultQoS
		case userInitiated
		case userInteractive
		case unspecified
		//var hashValue: Int { get }
	}
	init(qosClass: DispatchQoS.QoSClass, relativePriority: Int) {
		self.qosClass = qosClass
		self.relativePriority = relativePriority
	}
	private /*convenience*/ init(qosClass: DispatchQoS.QoSClass) {
		//self.init(qosClass: qosClass, relativePriority: 0) // E152 No accessible constructors for type DispatchQoS
		self.qosClass = qosClass
		self.relativePriority = 0
	}
}

infix func ==(a: DispatchQoS.QoSClass, b: DispatchQoS.QoSClass) -> Bool {  // wy is this needed?
	return a == b
}
func ==(a: DispatchQoS, b: DispatchQoS) -> Bool {
	return a.qosClass == b.qosClass && a.relativePriority == b.relativePriority
}

struct DispatchQueueAttributes /*: OptionSet*/ {
	let rawValue: dispatch_queue_attr_t
	init(rawValue: dispatch_queue_attr_t) {
		self.rawValue = rawValue
	}
	static let serial: DispatchQueueAttributes = DispatchQueueAttributes(rawValue: DISPATCH_QUEUE_SERIAL)
	static let concurrent: DispatchQueueAttributes = DispatchQueueAttributes(rawValue: DISPATCH_QUEUE_CONCURRENT)
	//static let qosUserInteractive: DispatchQueueAttributes
	//static let qosUserInitiated: DispatchQueueAttributes
	//static let qosDefault: DispatchQueueAttributes
	//static let qosUtility: DispatchQueueAttributes
	//static let qosBackground: DispatchQueueAttributes
	//static let noQoS: DispatchQueueAttributes
}

final class DispatchSpecificKey<T> {
	init() {
	}
}

//
// Time
//

struct DispatchTime {

	private init(rawValue: dispatch_time_t) {
		self.rawValue = rawValue
	}

	let rawValue: dispatch_time_t
	
	static func now() -> DispatchTime {
		return DispatchTime(rawValue: dispatch_time(DISPATCH_TIME_NOW, 0))
	}
	static lazy let distantFuture: DispatchTime = DispatchTime(rawValue: dispatch_time(DISPATCH_TIME_FOREVER, 0))

}
struct DispatchWalltime {

	init(time: __struct_timespec) {
		self.time = time
	}

	let time: __struct_timespec

	/*static func now() -> DispatchWalltime {
		return DispatchWalltime(time: dispatch_walltime(nil, 0))
	}
	static let distantFuture: DispatchWalltime = DispatchWalltime(time: dispatch_walltime(DISPATCH_TIME_FOREVER, 0))*/
}

enum DispatchTimeInterval {
	case seconds(Int)
	case milliseconds(Int)
	case microseconds(Int)
	case nanoseconds(Int)
}

prefix func -(interval: DispatchTimeInterval) -> DispatchTimeInterval {
	switch interval {
		case .seconds(let seconds):		   return DispatchTimeInterval.seconds(seconds)
		case .milliseconds(let milliseconds): return DispatchTimeInterval.seconds(milliseconds)
		case .microseconds(let microseconds): return DispatchTimeInterval.seconds(microseconds)
		case .nanoseconds(let nanoseconds):   return DispatchTimeInterval.seconds(nanoseconds)
	}
}

func +(time: DispatchTime, interval: DispatchTimeInterval) -> DispatchTime {
	switch interval {
		case .seconds(let seconds):		   return DispatchTime(rawValue: dispatch_time(time.rawValue, seconds	  * 1_000_000_000))
		case .milliseconds(let milliseconds): return DispatchTime(rawValue: dispatch_time(time.rawValue, milliseconds * 1_000_000))
		case .microseconds(let microseconds): return DispatchTime(rawValue: dispatch_time(time.rawValue, microseconds * 1_000))
		case .nanoseconds(let nanoseconds):   return DispatchTime(rawValue: dispatch_time(time.rawValue, nanoseconds))
	}
}
func +(time: DispatchTime, seconds: Double) -> DispatchTime {
	return DispatchTime(rawValue: dispatch_time(time.rawValue, Int64(seconds*1_000_000_000.0)))
}

/*func +(time: DispatchWalltime, interval: DispatchTimeInterval) -> DispatchWalltime {
}

func +(time: DispatchWalltime, seconds: Double) -> DispatchWalltime {
	//return DispatchWalltime(time: dispatch_time(time.time, Int64(seconds*1_000_000_000.0)))
}

func -(time: DispatchTime, interval: DispatchTimeInterval) -> DispatchTime {
	//return time + -interval // E119 Cannot use the unary operator "-" on type "DispatchTimeInterval"
}*/

func -(time: DispatchTime, seconds: Double) -> DispatchTime {
	return time + -seconds
}

/*func -(time: DispatchWalltime, interval: DispatchTimeInterval) -> DispatchWalltime {
	//return time + -interval // E119 Cannot use the unary operator "-" on type "DispatchTimeInterval"
}

func -(time: DispatchWalltime, seconds: Double) -> DispatchWalltime {
	return time + -seconds
}*/



//
//
//

class DispatchWorkItem {
	/*init(group: DispatchGroup? /*= default*/, qos: DispatchQoS /*= default*/, flags: DispatchWorkItemFlags /*= default*/, block: () -> ()) {
	}
	func perform() {
	}
	func wait(timeout: DispatchTime /*= default*/) -> Int {
	}
	func wait(timeout: DispatchWalltime) -> Int {
	}
	func notify(queue: DispatchQueue, execute: /*@convention(block)*/ () -> Void) {
	}
	func cancel() {
	}
	var isCancelled: Bool { get }*/
}

struct DispatchWorkItemFlags /*: OptionSet, RawRepresentable*/ {
	let rawValue: UInt
	init(rawValue: UInt) {
		self.rawValue = rawValue
	}
	//static let barrier: DispatchWorkItemFlags
	//static let detached: DispatchWorkItemFlags
	//static let assignCurrentContext: DispatchWorkItemFlags
	//static let noQoS: DispatchWorkItemFlags
	//static let inheritQoS: DispatchWorkItemFlags
	//static let enforceQoS: DispatchWorkItemFlags
	typealias Element = DispatchWorkItemFlags
	typealias RawValue = UInt
}

#endif