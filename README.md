**# Introduction #**

Ok, guys. This is my story. I has been a Flash Developer for years, has just tried to learn Objective-C for a few months, then Apple released a new Programming Language called Swift, the first time I looked at it, I felt it looked very close to Action Script syntax. After that, I decided to code a very first application by Swift, but when I start using UIAnimation.. I felt so disappointed! The easing looks very bad, I surprise that Apple didn’t give us the easing options?! 

My decision was changed, I put my very first app aside and tried to create a tween framework just like how TweenMax in ActionScript/Javascript. I named it **GTween** (G is actually a first character of my nickname - Goon)

My mind started to be blew off.. but finally I came up with a result. So far so good. Now check it out!

**# How it looks #**

If you’ve used TweenMax for ActionScript or Javascript, this line will look very familiar for sure:


```
#!Swift

GTween.to(target, time: 0.5, params: [x: 100, y:100, ease: Quint.easeOut])
```

In this example:
- “target” can be UIView, UILabel, UIImageView, UIButton,… 
- “time” will be how long the animation will be.
- “params” is a Dictionary which store the tween parameters, delay time and easing type.

How about set these values into the target imediately or after delay? Here, use this:

```
#!Swift

// This line will set the position of the view to {x:100px, y:100px} after 1 second
// Of course it doesn't contain "ease" or "events"
GTween.set(target, params: [x: 100, y:100, delay:1])
```

**# How to use #**

Drag the folder "GTween" into your xCode project, remember to check "Add to target", then you are ready to tween the objects

I made it to be very simple to use, let imagine that I have an UIView on the screen called “item”


```
#!Swift

@IBOutlet weak var item: UIView!
```


And I want to tween the position of this item to (200,100), so I need to tween the “x” and “y” value, with tween type Bounce.easeOut:


```
#!Swift

GTween.to(item, time: 2, params: [x:200, y:100, ease:Bounce.easeOut])
```


Easy, right? :)

But what if I want to tween the item after 4.5 seconds? Here you go, use “delay” :


```
#!Swift

GTween.to(img, time: 2, params: [width:250, height:250, ease:Back.easeInOut, delay:4.5])
```


Now this is the list of available variables which you can tween:


```
#!Swift

alpha
x
y
width
height
scaleX
scaleY
```

Then the list of available Tween types:


```
#!Swift

Linear (no easing animation)
Back
Quint
Elastic
Sine 
Bounce
Expo 
Circ 
Cubic 
Quart 
Quad
```

![[image-graphs]](https://bitbucket.org/repo/8nzR9B/images/3903256087-easing.jpg)s]](https://bitbucket.org/repo/8nzR9B/images/1128945927-easing.jpg)s]](https://bitbucket.org/repo/8nzR9B/images/4021603493-easing.jpg)

**# Events #**

You want to execute another function when the tween is finished? You want to know the progress of the tween? Don’t worry, these events will take care of that:

```
#!Swift

GTween.to(img, time: 2,
            params: [x:250, y:250, ease:Back.easeInOut, delay:2.5],
            events: ["onStart":{
                    println("I start to move!")
                }, "onUpdate": {
                    println("I'm movinggggg...")
                }, "onComplete": {
                    println("I'm at the new position!")
                }])
```

Currently it contains 3 optional events: "onStart", "onUpdate", "onComplete".

That’s it! 

Now I can go back with my very first app! I hope this **GTween** will make your life of Swift Coder become much easier. You’re welcome. 

It will have bugs, I can't fixed them all right now, I will improve this framework later when I have more free time, in the mean time, if you want to fork it, please feel free to, you guys must have a lot more experiences with iOS than me :)

**# Update 1 #**
Add the feature to set the values into the view.

```
#!Swift

// This line will set the position of the view to {x:100px, y:100px} after 1 second
// Of course it doesn't contain "ease" or "events"
GTween.set(target, params: [x: 100, y:100, delay:1])
```

*Cheers,
Goon Nguyen
duynguyen@topane.com*