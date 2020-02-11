# Fetch_Rewards_List

## General Notes:

Codebase should be pretty modular and clean. For view controller data functions are in a seperate file than UI functions. Any helper functions are in seperate files and folder. Project also should have no warnings or errors.

## UI:

1) I used Swift's Automatic Programtic Layout over the storyboard here to showcase this skill. I am equally capable with the Storyboard, but figured that this was an oppurtunity to show a skill that not every applicant will have.
2) When creating the cells, I gave a little colored circle on the left part of each cell. The colors are grouped by ListId. Each time it shold generate relatively random colors. 


## Data:

1) I make the calls in the background and use weak self when approriate to avoid any memory leaks.
2) I kept the API Key and Server Address in a Secret.swift file. I did this because in the real world application you would not want to have confidential credentials public facing. So it is assumed that the Secret.swift file would not be pushed anywhere and that those credentials would be shared in a secure mannor. 
