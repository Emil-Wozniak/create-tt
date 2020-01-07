

# CREATE-REACT-TT

The **create-react-tt** is a create-react-app overlay for a react application based on typescript and tailwind.

Script executes create, add dependencies and build react app with all required files for application including Typescript types and Tailwind  css.

# Requiredments

 - Yarn
 - NPM
 - create-react

## How to use script

All you need is go to your *dev* directory and execute script using bash shell .
for example:
    
    cd ~/dev/react/
    bash ~/dev/bin/create-reat-tt/create-react-tt.sh <app-name>
    cd <app-name>
    
   I recommend use aliases:

    alias create-rtt="bash ~/dev/bin/create-reat-tt/create-react-tt.sh"
    cd ~/dev/react/
    create-rtt <app-name>
    cd <app-name>

Make sure you use correct right path. I my computer I have *dev* directory in */home/(user)/* directory and store script in *dev/bin/create-reat-tt*.

## Ho script works

Script recognize both your work directory and where you store it, so you don't have to worry about the paths. 

If you forget to put app-name you will receive a massege like this:
<div>&nbsp;&nbsp;&nbsp;&nbsp;<font color="red"> [error]</font>&nbsp;&nbsp;&nbsp;&nbsp;   required number of args equals 1</div>


