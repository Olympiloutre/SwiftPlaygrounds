//
//  ViewController.swift
//  Playground_RxSwift_Basis
//
//  Created by Romuald Brochard on 29/4/19.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//
/*
 
                    PLAYGROUND FOR RxSWIFT
 
 Sources :
 - https://github.com/ReactiveX/RxSwift
 - https://rxmarbles.com/#concat
 - https://github.com/ReactiveX/RxSwift/blob/master/Documentation/GettingStarted.md
 - https://medium.com/ios-os-x-development/learn-and-master-%EF%B8%8F-the-basics-of-rxswift-in-10-minutes-818ea6e0a05b
 
 
 */

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Playground RxSwift")
        
        
        /*
        1 - Everything in RxSwift is an observable sequence or something that operates on or subscribes to events emitted by an observable sequence.
         Arrays, Strings or Dictionaries will be converted to observable sequences in RxSwift.
         You can create an observable sequence of any Object that conforms to the Sequence Protocol from the Swift Standard Library.
        */
        
        let helloSequence = Observable.just("Hello Rx")
        
        // You subscribe to observable sequences by calling 'subscribe(on:(Event<T>)-> ())'
        let subscriptionHello = helloSequence.subscribe { event in
            print(event)
        }
        
        /*
            OUTPUT :
             > next(Hello Rx)
             > completed
        */
        
        
        
        /*
         2 - Observable sequences can emit zero or more events over their lifetimes.
         In RxSwift an Event is just an Enumeration Type with 3 possible states:
         
         .next(value: T) — When a value or collection of values is added to an observable sequence it will send the next event to its subscribers as seen above. The associated value will contain the actual value from the sequence.
         .error(error: Error) — If an Error is encountered, a sequence will emit an error event. This will also terminate the sequence.
         .completed — If a sequence ends normally it sends a completed event to its subscribers
         
         */
        
        let helloArraySequence = Observable.from(["H","e","l","l","o"])
        let subscriptionHelloArray = helloArraySequence.subscribe { event in
            switch event {
            case .next(let value):  // on next value
                print(value)
            case .error(let error): // on error - Error type
                print(error)
            case .completed:        // on completion
                print("completed")
            }
        }
        
        /*
         OUTPUT :
         > H
         > e
         > l
         > l
         > o
         > completed
         */
        
        
        
        /*
         3 - Dispose a sunscription
         If you want to cancel a subscription you can do that by calling 'dispose' on it.
         You can also add the subscription to a Disposebag which will cancel the subscription for you automatically on deinit of the DisposeBag Instance.
         
         
         !! Dispose bags are used to return ARC like behavior to RX.
         When a DisposeBag is deallocated, it will call dispose on each of the added disposables. !!
        
            subscription.dispose() // called from main thread
         
         After the dispose call returns, nothing will be printed. That is guaranteed.
         
         */
        
        // Creating a DisposeBag so subscribtion will be cancelled correctly
        let bagJust = DisposeBag()
        let observableJust = Observable.just("Hello Rx!")
        let subscriptionJust = observableJust.subscribe (onNext:{ // Note : creating a subscription just for next events
            print($0)
        })
        // Binding the subscription to the disposebag
        subscriptionJust.disposed(by: bagJust)
        
        /*
         OUTPUT :
         > "Hello Rx!"
         
         no "completed" because we registered only for onNext(:)
         */
        
        
        /*
         4 - Subjects
         A Subject is a special form of an Observable Sequence, you can subscribe and **dynamically** add elements to it.
         
         There are currently 4 different kinds of Subjects in RxSwift :
         - PublishSubject: If you subscribe to it you will get all the events that will happen after you subscribed.
         - BehaviourSubject: A behavior subject will give any subscriber the most recent element and everything that is emitted by that sequence after the subscription happened.
         - ReplaySubject: If you want to replay more than the most recent element to new subscribers on the initial subscription you need to use a ReplaySubject. With a ReplaySubject, you can define how many recent items you want to emit to new subscribers.
         - Variable: A Variable is just a BehaviourSubject wrapper that feels more natural to a none reactive programmers. It can be used like a normal Variable.

         
           --- 'PublishSubject' ---
         
         */
        
        let bagPublish = DisposeBag()
        var publishSubject = PublishSubject<String>() // New Publish Subject
        
        
        let subscriptionPublish1 = publishSubject.subscribe(onNext:{ // Subscribe to the subject BEFORE
            print("sub 1 : \($0)")
        }).disposed(by: bagPublish)
        
        
        // You can add new Values to that sequence by using the onNext() function.
        // onCompleted() will complete the sequence and onError(error) will result in emitting an error event.
        publishSubject.onNext("Hello")  // add "Hello" to the sequence
        publishSubject.onNext("World")  // add "World" to the sequence
        
        
        let subscription2 = publishSubject.subscribe(onNext:{        // Subscribe to the subject AFTER
            print("sub 2 : \($0)")
        }).disposed(by: bagPublish)
        
        publishSubject.onNext("RxSwift")  // add "RxSwift" to the sequence
        
        /*
         OUTPUT :
         > "sub 1 : Hello"
         > "sub 1 : World"
         > "sub 1 : RxSwift"
         > "sub 2 : RxSwift"

         Note : Sub 2 didnot receive "Hello" qnd "World" because it subscribed to the subject AFTER
         */
        

        /*
         5 - Marble Diagrams
         If you work with RxSwift or Rx in general, you should get to know Marble Diagrams. A Marble Diagram visualizes the transformation of an observable sequence.
         
         -> https://rxmarbles.com/#concat
         
         */
        
        
        /*
         
         6 - Transformations
         
         "Sometimes you want to transform, combine or filter the elements emitted by an observable sequence before the subscriber receives them"
         
         --- 6.1 Map ---
         
         */
        
        // let sequence = Observable<Int>.from([1,2,3,4])
        // let subscription = sequence.map { value in ...
        
        Observable<Int>.of(1,2,3,4).map{ value in
            return value * 10
        }.subscribe(onNext: { event in
            print(event)
        })
        
        /*
         
         OUTPUT :
         > 10
         > 20
         > 30
         > 40
         
         Note : new way of writting it :
            let sequence = Observable<Int>.from([1,2,3,4])
            let subscription = sequence.map { value in ...}
         
         became :
            Observable<Int>.from([1,2,3,4]).map{}
                OR
            Observable<Int>.of(1,2,3,4).map{}

         we don't need to refer to the sequence, neither to the subscription itself
         
         
         
         
         --- 6.2 FlatMap ---
         
         "FlatMap merges the emission of these resulting Observables and emitting these merged results as its own sequence"
         
         */
        
        
        let sequenceFM1  = Observable<Int>.of(1,2)
        let sequenceFM2  = Observable<Int>.of(1,2)
        let sequenceOfSequencesFM = Observable.of(sequenceFM1,sequenceFM2)
        sequenceOfSequencesFM.flatMap{  // 'Flatter' the two seauences into one
            return $0
        }.subscribe(onNext:{
            print($0)
        })
        
        /*
         
         OUTPUT :
         > 1
         > 2
         > 1
         > 2
         
         
         
         --- 6.3 Scan (~reduce)---
         
         "Scan starts with an initial seed value and is used to aggregate values just like reduce in Swift."
         
         */
        
        Observable.of(1,2,3,4,5).scan(0) { seed, value in
            return seed + value
        }.subscribe(onNext:{
            print($0)
        })
        
        /*
         
         OUTPUT :   (Accumulator + Current)
         > 1        (0+1)
         > 3        (1+2)
         > 6        (3+3)
         > 10       (6+4)
         > 15       (10+5)
         
         
         
         --- 6.4 Buffer ---
         "The Buffer operator transforms an Observable that emits items into an Observable that emits buffered collections of those items."
         
         Observable<Int>.of(1,2,3,4,5,6)
             .buffer(timeSpan: 150, count: 3, scheduler:s)
         .subscribe(onNext:{
             print($0)
         })
         
        
         
         -----1--2------3---4---5-----6-7--------8--------->
         ---0------0-------0---------------0-----------0--->
         
         OUTPUT :
         
         ---[]-----[1,2]---[3]-------------[4,5,6,7]---[8]->

         
         
         
         
         
         
         --- 7. Filters ---
         
         --- 7.1 Filter ---
         
         */
        
        Observable.of(2,30,22,5,60,1).filter{
            return $0 > 10
        }.subscribe(onNext:{
            print($0)
        })
        
        
        /*
         
         OUTPUT :   (Accumulator + Current)
         > 30
         > 22
         > 60

         
         --- 7.2 DistinctUntilChanged ---

        "If you just want to emit next Events if the value changed from previous ones you need to use distinctUntilChanged."
         
         */
        
        Observable.of(1,2,2,1,3).distinctUntilChanged().subscribe(onNext:{
            print($0)
        })
        
        /*
         
         OUTPUT :
         > 1
         > 2
         > 1
         > 3

         Note : Only triggers 'onNext' when the next value is different from the previous one (thats why there is only one '2')
         
         Other elements :
         - Debounce
         - TakeDuration
         - Skip
         
         
         
         
         --- 8. Combine ---
         
         --- 8.1 StartsWith ---

         "If you want an Observable to emit a specific sequence of items before it begins emitting the items normally expected from it, use the startWith operator."
         
         */
        
        Observable.of(2,3).startWith(1).subscribe(onNext:{
            print($0)
        })
        
        /*
         
         OUTPUT :
         > 1  // added at the begining of a sequence
         > 2
         > 3

         
         
         
         
         
         --- 8.2 Merge ---
         
         "You can combine the output of multiple Observables so that they act like a single Observable, by using the Merge operator."
         
         */
        
        let publishMerge1 = PublishSubject<Int>()
        let publishMerge2 = PublishSubject<Int>()
        Observable.of(publishMerge1,publishMerge2).merge().subscribe(onNext:{
            print($0)
        })
        publishMerge1.onNext(20)
        publishMerge1.onNext(40)
        publishMerge1.onNext(60)
        publishMerge2.onNext(1)
        publishMerge1.onNext(80)
        publishMerge2.onNext(2)
        publishMerge1.onNext(100)
        
        
        /*
         
         OUTPUT :
         > 20
         > 40
         > 60
         > 1
         > 80
         > 2
         > 100
         
         
         --20---40---60---80---100----->
         ---------------1----2-------->
        OUTPUT :
         --20---40---60-1-80-2-100----->

         
         
         
         
         --- 8.3 Zip ---
         
         "You use the Zip method if you want to merge items emitted by different observable sequences to one observable sequence."
         
         */
        
        let seaqenceZip1 = Observable.of(1,2,3,4,5)
        let seaqenceZip2 = Observable.of("a","b","c","d")
        Observable.zip(seaqenceZip1,seaqenceZip2){
            return ($0,$1)
        }.subscribe( onNext: {
            print($0)
        })
        
        /*
         
         OUTPUT :
         > (1, "a")
         > (2, "b")
         > (3, "c")
         > (4, "d")
         
         
         --1---2---3---4---5----->
         ----a---b--c--------d--->
         OUTPUT :
         ----1a--2b-3c-------4d-->
         
         
         Other elenents :
         - Concat
         - CombineLatest
         - SwitchLatests

         
         
         
         --- 9. Side Effetcs ---
         
         "If you want to register callbacks that will be executed when certain events take place on an Observable Sequence you need to use the doOn Operator. It will not modify the emitted elements but rather just pass them through."
         
         */
        
        Observable.of(1,2,3).do(onNext: {
            // callbacks will be called on the onNext call on subscription
            print("do(onNext:) \($0)")
        }).subscribe(onNext:{
            print("subscribe(onNext:) \($0)")
        })
        
        /*
         
         OUTPUT:
         > do(onNext:) 1
         > subscribe(onNext:) 1
         > do(onNext:) 2
         > subscribe(onNext:) 2
         > do(onNext:) 3
         > subscribe(onNext:) 3
         
         
         
         
         
         --- 10. Schedulers ⏰ ---
         "Operators will work on the same thread as where the subscription is created. In RxSwift you use schedulers to force operators do their work on a specific queue."
         
         There are 5 Types of Schedulers in RxSwift:
         
         - MainScheduler — “Abstracts work that needs to be performed on MainThread. In case schedule methods are called from the main thread, it will perform the action immediately without scheduling.This scheduler is usually used to perform UI work.”
         - CurrentThreadScheduler — “Schedules units of work on the current thread. This is the default scheduler for operators that generate elements.”
         - SerialDispatchQueueScheduler — “Abstracts the work that needs to be performed on a specific dispatch_queue_t. It will make sure that even if a concurrent dispatch queue is passed, it's transformed into a serial one.Serial schedulers enable certain optimizations for observeOn.The main scheduler is an instance of SerialDispatchQueueScheduler"
         - ConcurrentDispatchQueueScheduler — “Abstracts the work that needs to be performed on a specific dispatch_queue_t. You can also pass a serial dispatch queue, it shouldn't cause any problems. This scheduler is suitable when some work needs to be performed in the background.”
         - OperationQueueScheduler — “Abstracts the work that needs to be performed on a specific NSOperationQueue. This scheduler is suitable for cases when there is some bigger chunk of work that needs to be performed in the background and you want to fine tune concurrent processing using maxConcurrentOperationCount.”
         
         
         */
        
        let publishSchedule1 = PublishSubject<Int>()
        let publishSchedule2 = PublishSubject<Int>()
        Observable.of(publishSchedule1,publishSchedule2)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background)) // observe on concurrent
            // .observeOn(MainScheduler()) // observe on concurrent
            .merge()
            .subscribeOn(MainScheduler()) // subscribe on main
            .subscribe(onNext:{
                print($0)
            })
        publishSchedule1.onNext(200)
        publishSchedule2.onNext(400)
        
        
        /*
         
         More on Schedulers :
         
         https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Schedulers.md
         
         */
        
        Observable<Int>.of(1,2,3,4)
            .observeOn(CurrentThreadScheduler.instance)
            .map { n in
                print("This is performed on the current scheduler")
            }
            .observeOn(MainScheduler.instance)
            .map { n in
                print("This is performed on the main scheduler")
        }.subscribe()
    }
}

