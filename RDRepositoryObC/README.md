#  RDRepositoryObC

This is a class library of API calls made with Objective-C.
But.. this code is Old..  Fashion Style...

Let's call Wikipedia's API as an example.

```objc
[RDWikipediaManager.sharedManager loadList:^(NSArray<RDWikipediaRecord *> * _Nullable records, NSError * _Nullable error) {
    NSLog(@"%@", [records description]);
}];
