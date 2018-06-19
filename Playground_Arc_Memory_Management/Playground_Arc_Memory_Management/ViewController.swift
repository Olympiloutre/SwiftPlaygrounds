//
//  ViewController.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 11/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//
/*
 
                    ARC MEMORY MANAGEMENT EXAMPLE
 
 Source :    https://www.raywenderlich.com/134411/arc-memory-management-swift
 
 [...]
 "The lifetime of a Swift object consists of five stages:
 
 1. Allocation (memory taken from stack or heap)
 2.     Initialization (init code runs)
 3.         Usage (the object is used)
 4.     Deinitialization (deinit code runs)
 5. Deallocation (memory returned to stack or heap)"
 
 [...]
 "Reference counting is the mechanism by which an object is deallocated when it is no longer required. "
 "Reference count indicates how many “things” reference the object."
 
 -> If the count is not equals to 0 this means that the object is still in use and therefore ARC won't dealloc it
 
  [...]
 
 
 
    I.   Strong Ref Cycle
 
    II.  Weak Reference
 
    III. Unowned Reference
 
    IV.  Note on closures
         A. Theory
         B. Example
 
    V.   Bonus : Cycles with Value Types and Reference Types
 
    VI.  Finding Strong Ref Cycle with XCode


 */


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        
        // MARK: --- I.   Strong Ref Cycle ---
         /*
         In this example, Class A owns Class B and vice versa with strong reference
         
         "How can leaks happen? Imagine a situation where two objects are no longer required, but each reference one another. Since each has a non-zero reference count, deallocation, of both objects, can never occur."
         
         
                         var1 ⇀ object1  ⇋ object2 ↼ var2
                                   2           2                        (< ref count)
         
                         v̶a̶r̶1̶   object1  ⇋ object2   v̶a̶r̶2̶
                                   1           1
         
                                object1  ⇋ object2
                                   1           1
         
         
         
         Note : Here we use a do{} block to simulate a dealloc when the block ends
         do {
            let classA = ClassA()
         } => will dealloc here

        */
        
        do {
            // init with ref to nil
            let sr_classA : StrongRefClassA = StrongRefClassA()
            let sr_classB : StrongRefClassB = StrongRefClassB()
            
            // referencing
            sr_classB.classA = sr_classA
            sr_classA.classB = sr_classB
        }
        /*
            StrongRefClassB and StrongRefClassA are NEVER deallocated because of ARC.
            ("StrongRefClassX is being deallocated" is never shown)
            "A strong reference cycle between the two objects prevents ARC from deallocating them."
         */
        
        
        
        
        // MARK: --- II.  Weak Reference ---
        /*
         
         To prevent this issue, one can use a 'Weak' reference.
         
         "Unless otherwise specified, all references are strong. Weak references, by contrast, don’t increase the strong reference count of the object."
         
         
                     var1 ⇀ object1  ⥃ object2 ↼ var2
                               2           1                    (< weak ref count don't increase)
         
                     v̶a̶r̶1̶   object1  ⥃ object2   v̶a̶r̶2̶
                               1           0
         
                            object1     o̶b̶j̶e̶c̶t̶2̶
                               0
         
                            o̶b̶j̶e̶c̶t̶1̶
         
         
         Note: Weak variable are always optionnal !
         
        */
        do{
            // init with ref to nil
            let wr_classA = WeakRefClassA()
            let wr_classB = WeakRefClassB()
            
            // referencing
            wr_classB.classA = wr_classA // Weak reference to classA in classB
            wr_classA.classB = wr_classB // ( Strong reference to classB in classA )
        
        }
        /*
             > "WeakRefClassA is being deallocated"
             > "WeakRefClassB is being deallocated"
         
         Note : In this example we only need to set ONE reference to Weak to get rid of the strong reference cycle
         Actually you can set both to weak it will also work
         
         */
        
        
        
        
        
        // MARK: --- III.  Unowned Reference ---
        /*
         
         "There is another reference modifier you can use that doesn’t increase the reference count: unowned."
         
         "What’s the difference between unowned and weak?
         WEAK
             -> A weak reference is ALWAYS optional and automatically becomes nil when the referenced object deinitializes.
             -> That’s why you must define weak properties as optional var types for your code to compile (because the variable needs to change).
         UNOWNED
             -> Unowned references, by contrast, are NEVER optional types.
             -> If you try to access an unowned property that refers to a deinitialized object, you will trigger a runtime error comparable to force unwrapping a nil optional type.
         "
         
         Note : This is because the unowned ref are never optional that the UnownedRefClassB needs an init
         
         */
        do{
            // init with ref to nil
            let ur_classA = UnownedRefClassA()
            let ur_classB = UnownedRefClassB(classA: ur_classA) // referencing // Unowned reference to classA in classB
            
            // referencing
            ur_classA.classB = ur_classB  // ( Strong reference to classB in classA )
            
        }
        /*
            > "UnownedRefClassA is being deallocated"
            > "UnownedRefClassB is being deallocated"
         
         "The question [may be] which of the two to choose [to be unowned]."
         
         In a real example this takes form, you select which class can exist without the other, and which can't.
         'Unowned' keyword is quite explicit
         
         
                                                    SIMPLE LAW :
         
         > unowned is a good fit since the object could not exist while the instance of it's parent has gone away.
         > weak is better for self standing instances that can run without this reference
         
         */
        
        
        
        
        
        
        
        // MARK: --- IV.  Note on closures ---
        /*
                    --- A.  Theory ---
         
         "Reference cycles for objects occur when properties reference each other. Like objects, closures are also reference types and can cause cycles. Closures capture (or close over) the objects that they operate on."

         
TODO : A AJOUTER DANS LE TUTO SUR LES CLOSURES !!
         
         
         */
        
        // Reminder
        do {
            var x = 2
            let myClosure = {   // Closures captures the REFERENCE of 'x' ...
                print("\(x)")
            }
            x = 3             // ... increment afterward ...
            
            myClosure()     // print 3 ( .. it prints it by reference )
            print("\(x)")   // print 3
        }
        
        
        // Introducing : 'the capture list'
        do {
            var x = 2
            let myClosure = { [x] in // Closures captures a COPY of 'x' ...
                print("\(x)")
            }
            x = 3             // ... increment afterward  ...
            
            myClosure()     // print 2! ( .. it prints its copy )
            print("\(x)")   // print 3
        }
        /*
         "The variable x is in the capture list, so a copy of x is made at the point the closure is defined."
         "It is said to be captured by value." !!!
         
         */
        
        
        // Another one
        do {
            var x = 5
            var y = 5
            
            let someClosure = { [x] in
                print("\(x), \(y)")
            }
            
            x = 6
            y = 6
            
            someClosure()        // Prints 5, 6 // only x is in capture list - only 'x' is a 'copy' 'y' is a 'reference'
            print("\(x), \(y)")  // Prints 6, 6
        }
        /*
         "The variable x is in the capture list, so a copy of x is made at the point the closure is defined. It is said to be captured by value.
         On the other hand, y is not in the capture list, and is instead captured by reference. This means that when the closure runs, y will be whatever it is at that point, rather than at the point of capture."
         */
        
        
        
        
        
        /*
                    --- B.  Examples ---
         
         This will become handy when it comes to break a reference cycle.
        
         Firstly, a simple one to illustrate the reference retain
         
         */

        do {
            var myClosure : () -> ()
            
            do {
                let closureClass = SimpleClass(str: "I am a string")
                myClosure = {
                    let str = closureClass.str
                    print(str)
                }
            } // 'closureClass' is NOT deallocated here, because it's referenced in 'myClosure'
            
            myClosure()
        } // 'myClosure' is deallocated then 'closureClass' is dealocated here
        
        
        /*
              ↑
         In this example there is NO PROBLEM of ARC functionning : that is true that we does not want the 'closureClass' to be deallocated considering 'myClosure' ca be used outside the intern 'do' scope
         There is no Strong reference cycle
         */
        
        
        
        
        /*
         
         BUT in some cases there can be a Strong reference Cycle, for instance in classes that contain a Closure that accesses it's own values.
         
         In this example, the accessed closure 'printStr' referes to it's owner class.
         This creates a Strong Reference Cycle inside a simple Class !
         
         */
        do {
            
            let myClassWithClosureStrongCycle = ClosureClassStrongRefCycle(str: "closure class strong cycle")
            myClassWithClosureStrongCycle.printStr()
            
        } // 'myClassWithClosureStrongCycle' is NEVER deallocated -> Strong reference cycle between this class and it's closure
        
        
        
        
        /*
         
         In here capture lists are usefull to get rid of this cycle, considering it allows us to define a reference modifier.
         
         "adding '[unowned self] in' inside the closure creates a new 'self' variable which shadows the existing 'self' variable just for the closure’s scope."
         
         Considering self is not a reference anymore, plus a unowned one, it can get rid of the class when it should be deallocated, the closure does not preventing it's deallocation
         
         */
        
        do {
            
            let myClassWithUnownedSelfReference = ClosureClassUnownedReference(str: "unowned self in closure class")
            myClassWithUnownedSelfReference.printStr()
            
        } // > "ClosureClassUnownedReference is being deallocated"
        
        
        
        /*
         This is the same as for classes, 'unowned' keyword means the value canot be optional, in opposition to 'weak' that can.
         
         In most cases it is prefered to use 'unowned' for closures cases, because typycally the closure of a function cannot exist without it's parent function ( cf SIMPLE LAW ).
         
         But considering a closure is stored by ref, we can imagine a closure that could exist even if it's parent has disappered :
         
         */
        
        var unownedClosureReference : () -> ()
        do {
            
            let myClassWithUnownedSelfReference = ClosureClassUnownedReference(str: "unowned self in closure class")
            unownedClosureReference = myClassWithUnownedSelfReference.printStr // referencing the 'printStr' closure inside another var
            
        } // > "ClosureClassUnownedReference is being deallocated"
        
        // unownedClosureReference() // CRASHES THE APP !!!!
       // > "Fatal error: Attempted to read an unowned reference but object 0x1c4277180 was already deallocated"
        
        
        
        /*
         
         For that purpose, as if we were in a Class case, we use the 'weak' keyword.
         Reminder : a weak object is always optionnal so the 'self' keyword for this example is refered as 'self?' 
         
         */
        var weakClosureReference : () -> ()
        do {
            
            let myClassWithWeakSelfReference = ClosureClassWeakReference(str: "unowned self in closure class")
            weakClosureReference = myClassWithWeakSelfReference.printStr // referencing the 'printStr' closure inside another var
            
        } // > "ClosureClassWeakReference is being deallocated"
        
        weakClosureReference() // print 'nil'
        
        /*
         
         Just as for Classes part, the SIMPLE LAW is used
         
         */

        
        
        
        
        
        
        
        // MARK: --- V. Bonus : Cycles with Value Types and Reference Types ---
        /*
         
         "Swift types can be categorized as reference types, like classes, and value types, like structures or enumerations.
         The major difference is that :
         - value types are copied when they are passed around
         - reference types share a single copy of referenced information."
         
         struct Node { // ERROR
             var anotherNode: Node? = nil
         }
         
         -> A Structure cannont be calling itself. More generally, a value type is not happy with recursivity and will cause an error. So there won't be any issue
         
         
         Regarding Classes, this is not a problem to call itself, which can lead to strong reference cycles, as seen in I. Strong ref cycle
         
         
         
         Here is another example concerning an Array of object of it's type, which is basically a Strong ref cycle like at the beginning
         
         */
        do {
            let classWithArrayA = ClassWithArrayCycle()
            let classWithArrayB = ClassWithArrayCycle()
            
            classWithArrayA.linked(to : classWithArrayB)
            classWithArrayB.linked(to : classWithArrayA)

        } // Strong ref cycle - no release
        
        /*
         Here the reference cycle is inside an array so the best way to deal with it is to manipulate a new Class of object, functionning with Generics ( cf ClassWithoutArrayCycle )
         */
        
        do {
            let classWithoutArrayCycleA = ClassWithoutArrayCycle()
            let classWithoutArrayCycleB = ClassWithoutArrayCycle()
            
            classWithoutArrayCycleA.linked(to : classWithoutArrayCycleB)
            classWithoutArrayCycleB.linked(to : classWithoutArrayCycleA)
            
            print(classWithoutArrayCycleA.connexion.first?.value) // here is how to gather the value
            
        }
        /*
         Subclass defined by generics allows us to make the 'connexion' list contains 'unowned' objects
         Note: Would have works with 'weak'
         */
        
        
        
        
        
        
        // MARK: --- VI. Finding Strong Ref Cycle with XCode ---
        /*
         
         At this stage of the code running, we have several Strong reference cycle remaining in the app.
         
         Here is how to see it in XCode Debug Panel :
         1. click the 'Debug Memory Graph' button ( the 3 cicles linked above console )
         
         2. On the left panel you can see the warning with purple exclamation points that indicates which entities are in a retain cycle by class type
         
         3. Here we can se :
            - a StrongRefClassA ( retained by a StrongRefClassB )
            - a StrongRefClassB ( retained by a StrongRefClassA )
            - a ClosureClassStrongRefCycle ( retained by itself )
            - 2x ClassWithArrayCycle ( retained by lists )
         
         */
        
        
        
        
    }

}

