# FT

## Getting started

I have used my own [LXCore library](https://github.com/artakgev/LXCore) for network layer. Usually LXCore is a framework which includes network layer, 
extensions and UI components. It was used in many projects in my previous projects. LXCore is oriented to that project needs but I have plans to
make it more generic. My dream is make it like Firabase libs ). This is my upcoming challenge. 

### Steps to Run the App

- Run ./setup.sh command. This will install LXCore git submodule in main directory. After successsful run you can find LXCore folder 
- Install pods.
- Open FT.xcworkspace and run FT target.


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

Besides of above mentioned LXCore I would like highglight the following parts:
- I'v used MVVM pattern with Coordinators. Each screen has it's own VC (view controller), VM (view model) and Coordinator files. 
Usually I am deviding similar views (which are part of single flow) into one storyboard. 
I think that include all views of project into one storoyboard is not good idea, 
especiall when there are working more than one developers on the same project cause most probably there will be merge conflicts in stoyboard.
I am sure that fixing storyboard merge conflicts is not so "happy" job for every developer)
That's why I try to have multiple storyboards, for example Auth.storyboard for all views which are part of authentication flow.
Unfortunatelly in this project I could not manage time to follow that principe. It just because of time.

- All views and view models are inherited from BaseVC and BaseVM classes
- there some useful protocols which are "bridges" between view controller and view model. 
VMToVCExchange for example transfer data from view model to view controller.
 
- Swiftgen for easy and safe access to resources (storyboards, images, fonts)
- Kingfisher for image download/caching process 

Of course I have not implemented all functionality from scratch. I'v used a lot of parts from my previous projects.
I will be happy if you will give me chance to discribe and discuss project with your team.   

