# Garden-Wall
A swift application to manage Safari content blocking. Inspired heavily by krishkumar's [Block Party](https://github.com/krishkumar/BlockParty). 


## Features
+ Curated list of adblocking rules
+ Whitelist websites to allow advertisements
+ Build custom rules

<img src="http://imgur.com/spgqqil.png"  height=500 />
<img src="http://imgur.com/dvffGJL.png"  height=500 />
<img src="http://imgur.com/ywsVb9M.png"  height=500 />
<img src="http://imgur.com/aUhmYxv.png"  height=500 />
<img src="http://imgur.com/j7YnJZD.png"  height=500 />
<img src="http://imgur.com/19KHpGC.png"  height=500 />



## Installation
``` bash
git clone https://github.com/FrancisBaileyH/Garden-Wall.git Garden\ Wall
cd Garden\ Wall
pod install
open Garden\ Wall.xcworkspace
```


## Known Issues
+ Updating an existing custom rule that has loadType or resourceType values set will result in an immutable value, this is a known issue with the underlying library SwiftForms
+ Enabling Adblocker button only shows popup. Currently there is no API in place to change values from the application.
+ Primitive validation on custom rules and whitelisted rules


## Third Party Libraries 
+ GBVersionTracking
+ ObjectMapper
+ SwiftForms
+ SwiftyJSON


## License
The MIT License (MIT)

Copyright (c) 2015 Francis Bailey

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
