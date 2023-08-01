Here in this project i have developed a Flutter app that will aid in monitoring a city for clusters of affected areas.The houses within each block are arranged in a grid pattern and each house is assigned a unique identifier in the format H1, where H1 represents the house number.
Our aim is to enable users to view all the houses in a block, along with the total number of houses, infected houses, and number of infected clusters in each block. An infected cluster is defined as a group of infected houses that are adjacent to at least one other house in the same group.

In this Project i have provided:

1) The number of houses, infected houses and infected clusters in each block.

2) Upon tapping on a block, visually represent the block as a grid with infected houses marked in red.

3) A house can be marked as infected just by tapping on it. Tapping on it again should clear the infected status.

4) Design the model to store all relevant data in Firestore #FirestoreModelDesign.

5) Implement real-time updates from Firebase and manage the state using Cubits #FirebaseUpdates #StateManagement.
