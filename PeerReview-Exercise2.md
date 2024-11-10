# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Hanson Lau
* *email:* hklau@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The student's implementation of Stage 1 met all requirements and it worked without an issues. The camera is always centered on the vessel and the cross is 5 by 5 in the center. Also works fine with the speed boost.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera is able to auto scroll at the rate that is setup in Godot. The vessel stays inside the box and can't get outside of it. The speed and direction of the autoscroll can easily be modified because of the export variables.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera properly lags behind the the vessel as the vessel moves. The leash distance is handled properly and teh vessel does not go further than that boundary. The camera movement is very smooth and followed the vessel nicely. One small thing is that the vessel does jitter when boosting, but this can be due to difference of frame rates or other factors, so I wouldn't consider it a flaw.

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Similar to stage 3, the camera movement is very smooth. The vessel properly follows the camera and delays for a little bit before going back to the center of the camera. There was no jittering when the speed boost was used.

___
### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
When the vessel is at the appropriate positons, the camera moves at the right speeds (ex: same speed as vessel when vessel is at the edge, and speed multiplied by push_ratio when vessel is not at the edge). The camera doesn't move when the vessel in within the inner box. 
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
In some variable declarations, there was no space beween the colon and the type. Here is an example of one:
https://github.com/ensemble-ai/exercise-2-camera-control-patle621/blob/5fc9dff61d3a3b8c6803bf877a2583dcdd1e1f15/Obscura/scripts/camera_controllers/position_lock.gd#L4

There should also be two new lines between different functions, this includes two new lines between the variable declarations and the first function. 
https://github.com/ensemble-ai/exercise-2-camera-control-patle621/blob/5fc9dff61d3a3b8c6803bf877a2583dcdd1e1f15/Obscura/scripts/camera_controllers/position_lock.gd#L24


Variable types could've been included during intialization to make the type more certian:
https://github.com/ensemble-ai/exercise-2-camera-control-patle621/blob/5fc9dff61d3a3b8c6803bf877a2583dcdd1e1f15/Obscura/scripts/camera_controllers/pos_lock_lerp_smooth.gd#L18

#### Style Guide Exemplars ####
I appreciate the spacing between certain code blocks in side a function. It cleary shows when a portion of the code handles a different part of the game logic. The functions and variable names were ordered according to the style guide!

___
#### Put style guide infractures ####
Although this was shown above, I'll also put the infractions here:

https://github.com/ensemble-ai/exercise-2-camera-control-patle621/blob/5fc9dff61d3a3b8c6803bf877a2583dcdd1e1f15/Obscura/scripts/camera_controllers/position_lock.gd#L4

https://github.com/ensemble-ai/exercise-2-camera-control-patle621/blob/5fc9dff61d3a3b8c6803bf877a2583dcdd1e1f15/Obscura/scripts/camera_controllers/position_lock.gd#L24

https://github.com/ensemble-ai/exercise-2-camera-control-patle621/blob/5fc9dff61d3a3b8c6803bf877a2583dcdd1e1f15/Obscura/scripts/camera_controllers/pos_lock_lerp_smooth.gd#L18
___

# Best Practices #

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
For certian cameras where the variables are specific for the indiviual camera, they can be made private. scroll_position would be private and only used in auto scroll:
https://github.com/ensemble-ai/exercise-2-camera-control-patle621/blob/5fc9dff61d3a3b8c6803bf877a2583dcdd1e1f15/Obscura/scripts/camera_controllers/horiz_auto_scroll.gd#L11 

Vessel has already been tied to an export variable in the CameraControllerBase class, and it is called target:
https://github.com/ensemble-ai/exercise-2-camera-control-patle621/blob/5fc9dff61d3a3b8c6803bf877a2583dcdd1e1f15/Obscura/scripts/camera_controllers/lerp_smooth.gd#L13

It is beneficial to use _physics_process instead of _process to deal with the vessel's movement. Personally, it made my jittering issue go away and it didn't matter what frame rate I ran my game at.

#### Best Practices Exemplars ####
The comments that were added in each function complemented the code very well. The comments themselves weren't too verbose and were straight to the point. I see that a good amount of commits were made as well which is great for version control and for tracking progress! Again, the spacing between code blocks that handled different logic made the code more intutive to understand.