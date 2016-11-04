# 60212
Includes work done for the class 60-212: Interactivity and Computation

Line_Intersections (in both p5.js and Processing)- 9/9/16 - Generates random line segments of a constant length, and draws a circle at every point of intersection.

Clock (p5.js)- 9/16/16 - A digital clock with a rudimentary physics system. There are 132 "marbles", each with a number on it. The marbles grow and shrink based on what time it is, and the three largest marbles display the hours, minutes, and seconds.

Interruptions (p5.js) - 9/23/16 - A piece of generative art designed to mimic Vera Molnar's piece entitled "Interruptions." Short line segments are generated in a random but highly controlled way. In places, large clumps of lines are missing.

Animated Loop (p5.js)- 9/23/16 - A simple animation that shows line segments "climbing" down a ladder of horizontal line segments, forming stripes and squares as they go. It loops indefinetely.

Three_Trees_PDF (Processing) - 10/30/16 - Displays (and saves as a pdf) a random set of eight topographically unique binary trees, with some random wiggling for added character. Example pdf "pretty_nice_trees" is included in folder.

Three_Trees (Processing) - 10/30/16 - Displays a random set of eight topographically unique binary trees, with some random wiggling for added character. Also sends real time commands for Axidraw machine to paint these trees, including returning to the ink well (if Axidraw machine is hooked up). Video of this executing "Three_Trees.mp4" is available here: https://www.youtube.com/watch?v=fv8tembgAcA&feature=youtu.be.

FaceOSC_Baby (Processing) - 10/14/16 - Takes input from FaceOSC (using a template that I didn't write) and displays a randomly generated 2-D baby that reacts to the user's face. It laughs at "funny faces" (raised eyebrows or wide open mouth), and gets scared when no face can be found. A video demo is available here: https://www.youtube.com/watch?v=tGE3oD4zXOQ

Song_Book (Processing) - 10/28/16 - Generates sheet music for 30 songs with randomly generated notes (that follow a computer-selected chord progression and key) and randomly generated lyrics (with end rhyme but no logical meaning), and then creates a pdf file for a song book containing these songs and a table of contents. Example pdf "song_book.pdf" is included in folder. A more detailed description of how the code for this project works "GENESONG PROCESS.pdf" is also included.

Bike Data Visualization (d3, Processing, and HTML) - 11/4/16 - Analyzes data from Healthy Ride PGH about bike rentals in Pittsburgh. The data is in the form of .csv files in the 2016-Q3 folder, and copies of it are in each of the other folders as well. export2darray.pde is a Processing file that generates a myMatrix.txt file containining a matrix counting the number of rides from each stop to each other stop. export2darraylimited.pde generates a similar myMatrix.txt file containing a smaller matrix, that only maps the rides between the 10 busiest stops and a generic "other." These matrices were then copied into index.html, which included a portion of script written in d3. index.html displays a chord diagram that illustrates all of the rides between stops. "All Data Graph"
