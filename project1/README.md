# Project 1: Maze Solver
CMSC 330, Spring 2020
Due: February 11th (Late Deadline: February 12th).


**This is an individual assignment. You must work on this project alone.**

### Introduction
As we saw in lecture, Ruby provides rich support for tasks that involve text processing. For this project, you'll write a Ruby program that processes text files containing maze data, and you will analyze that data to determine certain features of each maze. The goal of this project is to allow you to familiarize yourself with Ruby's built-in data structures and text processing capabilities.
### Project Files
To begin this project (and all other projects for this course), you will need to clone the git repository. [Click here for directions on cloning the repository.][cloning instructions] The following are the relevant files:
<!-- TODO add the real files to the document and ensure that they're correct -->
- Ruby Files
    - **maze.rb**:  The file you will be editing.  It's used to process maze files, which are text files that are passed in as arguments to the `main()` method. `main()` has two arguments, `command_name` and `file_name`
    - **runner.rb**: A command line script used to debug and test your program.  The arguments should be as follows:
```text
ruby runner.rb <command_name> <file_name>
```

Maze File Format
------------------
Mazes are defined in text files according to the format we describe next, which we will refer to as the *simple maze data file format*.  The maze.rb we have provided includes a parser for files in this format.  In the last part of the project, you will have to write a parser for files in a different format.

The maze data files have a relatively simple structure.  Here's an example:
```text
16 0 2 13 11 
0 0 du 123.456 0.123456
0 1 uldr 43.3 5894.2341 20.0 5896.904
... 
path path1 0 2 urdl
path path2 0 2 dlr 
```
The first line in the file is the maze *header*.  It has the form:

```text
<size> <start_x> <start_y> <end_x> <end_y>
```

These fields indicate (respectively) the size of the maze and the (x,y) coordinates for the start and end points. All mazes are square, so the size indicates both the length and the width. Coordinates start in the upper left-hand corner of the maze and increase as they move down and right. For example, in a maze of size 16, (0,0) is the upper-left corner, and (15,15) is the lower-right corner. With this coordinate system, moving *down* from a cell increases its y value, and moving *right* from a cell increases its x value. Thus going up from (5, 8) would take you to (5, 7), going down would take you to (5, 9); going left or right would respectively lead to (4, 8) and (6, 8).

Unlike common mazes that one might find on paper, the start and end points are arbitrary points *inside the maze*. A valid maze has no openings in the outer wall. The outer perimeter of the maze is a single, solid wall, so you needn't worry about accidentally walking through an open wall out into the space outside the maze.

Every line beyond the first can represent either a *cell* in the maze or a *path* through the maze. Each cell specifies where walls are (more precisely are not) in the maze, while a path is a trip through the maze defined by the cells.

Lines representing *cells* take the form:

```text
<x> <y> <dirs> <weights>
```
The `dirs` part is a set of up to four "open wall" characters, (any combination of 'udlr', representing up, down, left, right), followed by up to four floating point weights (separated by spaces), one per character in `dirs`. For example,
```text
4 7 lur 1.3 5.6 8.2
```
indicates that the cell at coordinates (4,7) has openings that lead left, up, and right from that cell (and thus there is a wall that prevents movement down). The characters can appear in *any* order, but may only include 'udlr', and each letter may appear at most once. A direction is *not* passable if its representative character is *not* in this list. Similarly, if a maze specification does not mention a particular cell, then you can presume that all of that cell's walls are closed.

Following the list of open walls is a list of *weights* for each wall opening. These appear in the same order as the open walls: in the example above, the left opening has weight 1.3, the up opening has weight 5.6, and the right opening has weight 8.2. We'll explain what these weights will be used for later.

Lines representing *paths* take the form:

```text
path <path_name> <start x> <start y> <move 1><move 2>...
```
In the simple format, there is one path per line. Each path consists of a name, a starting x/y coordinate, and a list of directions (which we'll call "moves"), all concatenated together, that the path takes to reach its destination. The start coordinates must consist only of integers, and directions may only include the letters "u," "d," "l," and "r,"; for example:

```text
path path1 0 2 uurrddll
```

The path path1 starts at coordinates (0,2) and then proceeds up twice, right twice, down twice, and left twice, to reach its ending point (which happens to be the same as the starting point).

The maze.rb file we have given you will parse in the data in this format. The parser is invoked by the mode `print`, which prints its results so you can see how it has parsed the different parts of the maze. (You'll change the implementation of `print` before finishing the project, as described below.)

## Part 1: Find Maze Properties
The first thing your program will do, of course, is to read in the maze using the parser provided. You may assume that maze files in the simple format, which we use in parts 1 through 5 of this project, are valid.

Once the maze is read in, your program will compute various properties of the maze, according to the command (mode) it is given. Here are three simple properties you'll compute: the number of open cells in the maze, the number of "bridges", and the list of all cells sorted by their number of openings.

First, if we invoke your script with the mode `open`, your script should output one line listing the number of cells for which all for directions are open. For example,
```
% ruby runner.rb open inputs/maze1
2
```
The two open cells are at the second row, second and thrid column. (See the pretty-printed version of maze1, below, for a visual depiction.)

Second, if we invoke your script with the `bridge` mode, your script should output the number of vertically or horizonally open 1-by-3 locations in the maze. Bridges can overlap. For example,

```
% ruby runner.rb bridge inputs/maze1
6
```
The bridges are:

second row, column 0,1,2; second row column 1,2,3; third row column 0,1,2; second column row 0,1,2; third column row 0,1,2; third column row 1,2,3.

Finally, if we invoke your script with the `sortcells` mode, your script should print the cells sorted by the number of openings. For example,
```
% ruby runner.rb sortcells inputs/maze1
0,(1,3),(3,0)
1,(0,0),(0,3),(3,2),(3,3)
2,(0,1),(0,2),(1,0),(2,0),(2,3),(3,1)
3,(1,2),(2,2)
4,(1,1),(2,1)
```
The output indicates that two cells (1,3) and (3,0) have no openings, four cells have one opening, etc. Cells with same number of openings are sorted by their column, then row.

## Part 2: Process & Sort Paths By Cost

As described in the introduction, some maze files will contain paths. Only paths that travel between cells through openings are *valid*. For each valid path, you will need to use the weights for each opening in the maze to calculate the *cost* of the path. For example, if the coordinates (in a simple maze file)
```text
path path1 0 1 drdu
```
appear in a path, and the cell at (0,1) is defined as

```text
0 1 ldr 342.54 958.1 3.126
```
the cost of the first move in the path will be 958.1 (the weight for the "d" opening). The cost of a whole path is the *sum* of the weight of each opening through which it passes. You may assume no two paths will have the same cost.

Once you have found which paths are valid and calculated the cost of each valid path, you need to print out the cost and name of each valid path, in order of cost from lowest to highest. For each valid path print its cost (with exactly 4 decimal places) and name on a separate line, separated by a single space. Hint: you can use printf("%10.4f",x) to print out a float value to 4 decimal places.
```
% ruby runner.rb paths inputs/maze2
   99.9958 path1
  103.7790 path2
```
Any paths that are not valid should not be output. If a maze contains no valid paths (or no paths at all), your program should simply print none.
```
% ruby runner.rb paths inputs/maze1
none
```
## Part 3: Pretty-print Maze

The textual specification of mazes makes them difficult to understand. For this part of the assignment, you'll implement a "pretty-printing" function for mazes. Your pretty print format will use the following conventions:

- Each cell will be represented by either a space, the letter "s" (for the start cell), or the letter "e" (for the end cell).
- Left/right walls will be represented by a pipe character "|", up/down walls will be represented by a dash "-", and wall junctions will be represented with a plus "+".
- If the maze file contains paths, print asterics in the cells on the shortest (cost of path is smallest) path. If the shortest path includes the start cell or end cell, print capital letter "S" or "E" instead of "s" or "e".

Your program will print a maze in this format when executed with the `print` command.

Here is an example maze that starts at (0,0) and ends at (3,3):
```
% ruby runner.rb print inputs/maze1
+-+-+-+-+
|s|   | |
+ + + +-+
|       |
+-+ + + +
|     | |
+ +-+ +-+
| | |  e|
+-+-+-+-+

ruby runner.rb print inputs/maze2
+-+-+-+-+
|E|   | |
+ + + +-+
|* *    |
+-+ + + +
|* *  | |
+ +-+ +-+
|S| |   |
+-+-+-+-+

ruby runner.rb print inputs/maze3
+-+-+-+-+
| |   | |
+ + + +-+
|       |
+-+ + + +
|* * *| |
+ +-+ +-+
|S|e|* *|
+-+-+-+-+
```
In maze2, the shortest path includes the start and end cells. In maze3, the shortest path includes the start cell, but does not include the end cell.

## Part 4: Find Distance of Cells From Start

Next, you need to analyze all the openings in a maze to determine the *distance* of all cells reachable from the start of the maze. For this project, we define distance between two cells a and b to be the number of up/down/left/right cell openings that are passed through when traveling from a to b. If there are multiple paths from a to b, the path with the shortest distance is the distance between a and b. The distance of the start cell from itself is always 0. If there is no valid path from a to b (i.e. b is not reachable from a) then the distance from a to b is undefined.

Once you have calculated the distance for all cells reachable from the start cell, print out the results in order of increasing distance. On each line, first print out the distance d, followed by all cells reachable from the start cell for that distance d. Cells should be printed as coordinates (x,y) in lexicographic order, separated by commas. Note that the first line will thus always be distance 0 followed by the location of the starting point of the maze.
```text
% ruby runner.rb distance inputs/maze2
0,(0,3)
1,(0,2)
2,(1,2)
3,(1,1),(2,2)
4,(0,1),(1,0),(2,1),(2,3)
5,(0,0),(2,0),(3,1),(3,3)
6,(3,2)
```
## Part 5: Decide Whether Maze is Solvable

Now use your script to determine whether or not a maze can be solved. You can do this by actually finding a path from the start to the end (that is, by solving the maze), or by using the cell distances calculated previously.

You do *not* need to return a path representing a solution from start to finish. Your program will only need to indicate whether a path *exists* by printing "true" when a maze can be solved and "false" otherwise.
```
% ruby runner.rb solve inputs/maze1
true
```
## Part 6: Parse Standard Maze Files

For this last part, we consider a new maze file format, called *standard maze files*, which is more complex. If we invoke your script with the mode `parse`, your script needs to read in and parse a standard maze file using Ruby regular expressions, then output the maze in the simple maze file format. If any part of the parsed in maze is invalid, then the output will be different; we discuss these situations further below.

**Standard maze file format**

We begin by describing the standard maze file format in full detail. Here's an example:
```text
  size=16 start=(0,2) end=(13,11)
  0,0: du 123.456,0.123456
  0,1: uldr 43.3,5894.2341,20.0,5896.904
  ...
  path:"path1",(0,2),u,r,d,...,l; path:"path2",(0,2),d,r,l,...,r
```
A standard file contains several lines of text according to the following format. The first line is the header, as in the simple case, and is now formatted as follows:
```text
size=<size> start=(<start_x>,<start_y>) end=(<end_x>,<end_y>)
```

Notice that now the size, starting position, and ending position are specifically identified by keywords (size, start, and end, respectively). The spacing should be just as shown above: no spaces before or after the equals sign, and one space between keywords. All of the elements in <> should be nonnegative integers, for example `+4` is not an integer whereas `4` is, (and size should be at least 1). Lines missing any of the above formatting or having extra or missing spaces are invalid. If the header is invalid, then the output should only include the header as invalid, and no other lines need to be checked. For example the header
```text
size=+4 start=(0,3) end=(0,0)
```
is invalid, and thus the output should be:
```text
invalid maze
size=+4 start=(0,3) end=(0,0)
```
The start and end coordinates do not have to be logically valid (i.e., exist within the maze), but still must be formatted correctly.

Lines representing *cells* take the form:

```text
<x>,<y>: <dirs> <weights>
```

Following the coordinates (x and y, separated by a comma) is a colon, a space, a set of up to four "open wall" characters ('udlr'), and a comma-separated list of floating point weights (with no space between the commas). Recall the following cell earlier specified in the simple format:

```text
4 7 lur 1.3 5.6 8.2
```

Here is the same specification in the standard format:
```text
4,7: lur 1.3,5.6,8.2
```

It is acceptable for weights to be negative, as well as signed integers (i.e., `+1` and `-1` are both valid weights). The number of "open wall" characters must match the number of weights, and it cannot contain two of the same character. For example:
```text
4,7: lurl 1.3,5.6,8.2,5.5
```
and
```text
4,7: lur 1.3,5.6
```
are invalid.

Lines representing *paths* take the form:

```text
path:"path1_name",(<start x>,<start y>),<move1>,<move2>,...; path:"path2_name",(<start x>,<start y>),...;
```
There are several differences with how paths are formatted in standard maze files, compared to simple maze files. First, each line of text may contain more than one path, with each path separated by a semi-colon followed by a space; the final path also ends with a semi-colon, but no trailing space after it. Each path begins with the keyword path followed immediately by a colon, and then the path name, contained in quotes. Path names can contain any character except space or colon, and quotation marks in path names will be *escaped* (\\"). The first line in the example below shows two path specifications; each path is identified by the second line below (which would not appear in an actual data file):
```text
path:"path1",(0,2),l,r; path:"path2",(0,2),d,u,l;
[     first path      ] [     second path      ] 
```
Note that in these examples the last path ends in a semi-colon, but without a trailing space.

If path names have escaped quotes in them, there is no requirement that they correspond to open and closed marks, i.e., you can have any number of escaped quotes in a path's name. 
In the example
```text
path:"hello-\"world\"",(0,2),u,r,d; path:"goodbye-world",(0,2),d,r;
```
The first path (named hello-"world") starts at (0,2), continuing to (0,1), (1,1), and (1,2). The second path (named goodbye-world) also starts at (0,2), but instead moves to (0,3) and (1,3).

If any path names contain escaped quotes, they must be converted to normal quotes. For instance the names path\\"3\\" and \\"path4\\" should be converted to path"3" and "path4" in the simple maze file format output. A path name can be empty (i.e., `""`)

In your output, all lines should be in the same order they were in the input file. For example, if path1 came first, and then path2, then make sure these come in the same order and same position in the output file.

Paths do not need to make any logical sense in the maze or have any directions. For example (in a maze of size 4):
```text
path:"",(0,3);
```
and
```text
path:"path",(0,5),u,u,u,u,u,u,u;
```
are valid paths. Put simply, you only need to check for proper formatting, not logical sense in the maze.

**Invalid standard mazes**

Some lines in a standard maze file may be invalid, i.e., they may not be in the format described above. If any such invalid lines exist, your script should output invalid maze followed by each invalid line in the maze file.

For examples:
```text
  % ruby runner.rb parse inputs/maze1-std
  ...prints out maze1-std in simple maze format...
  % ruby runner.rb parse inputs/maze3-std
  invalid maze
  ...prints out all invalid lines in maze3-std...
```

Furthermore, some lines in a standard maze file, while well formed, may make no logical sense. In particular, they may define cells within the maze that have openings that contradict neighboring cells within the maze or the outer walls of a maze (which should always be closed). If any such cells contradict with regard to their specified openings, your script should output invalid maze followed by the lines from the standard maze file corresponding to whichever cells contradict.

For example:

```text
  size=16 start=(0,2) end=(13,11)
  0,0: u 0.123456
  0,1: uldr 43.3,5894.2341,20.0,5896.904
  ...
```

The above two cells are correct in terms formatting but contradict in terms of the cell openings they specify. As such, both cell lines should be printed as invalid, i.e.,

```text
invalid maze
  0,0: u 0.123456
  0,1: uldr 43.3,5894.2341,20.0,5896.904
  ...
```

A standard maze file may contain invalid lines due to formatting and/or cell opening agreement issues; however, there will not be a line that has both formatting and cell opening agreement issues. Any maze file containing a cell opening agreement issue will have a validly formatted header line describing the size, start and end of the maze.

If a cell is not defined in the file or is not formatted correctly, this cell acts as a wildcard. This means the cell is undefined (neither open or closed), and is simply defined by its adjacent cells (i.e., the openings/walls of the neighbors define the cell).



## Hints and Tips
- This project is non-trivial, in part because you will probably be writing in Ruby for the first time, so be sure to start right away, and come to office hours if you get stuck.
- Follow good program development practices: Test each part of your program as you develop it. Start developing a simplified solution and then add features as you are sure that earlier parts work. Test early and often, and re-run your tests as you add new features to be sure you didn't break anything.
- Before you get too far, review the Ruby class reference, and look for classes and methods that might be helpful. For example, the Array and Hash classes will come in handy. Finding the right class might save you a lot of time and make your program easier to develop.
- Beware: iterating over hash mappings is not guaranteed to happen in a particular order.
- If you write methods that should return a true or false value, remember that a Ruby 0 is not false.
- Ruby has an integrated debugger, which can be invoked by running Ruby with the -rdebug option. The debugger's p command may be helpful for viewing the values of variables and data structures. The var local command prints all of the local variables at the current point of exclusion. The chapter When Trouble Strikes of The Pragmatic Programmer's Guide discusses the debugger in more detail.
- To thoroughly debug your program, you will need to construct test cases of your own, based on the project description. If you need help with this, please come to TA office hours.
- Remember to save your work frequently---a power failure, network failure, or problem with a phone connection could cost many hours of lost work. For the same reason, submit your project often. You can retrieve previously-submitted versions of your program from the submit server should disaster strike.
- Be sure you have read and understand the project grading policies in the course syllabus. Do this well in advance of the project due date.


Project Submission
------------------
You should submit a file `maze.rb` containing your solution. You may submit other files, but they will be ignored during grading. We will run your solution as MiniTest test units, just as in the provided public test file.

Be sure to follow the project description exactly! Your solution will be graded automatically, so any deviation from the specification will result in lost points.

You can submit your `maze.rb` file directly to the [gradescope server][gradescope server]. 

Use the submit dialog to submit your `maze.rb` file directly. Select your file using the "Browse" button, then press the "Submit project!" button. You **do not** need to put it in a zip file.

No matter how you choose to submit your project, make sure that your submission is received by checking the results after submitting.

Academic Integrity
------------------
Please **carefully read** the academic honesty section of the course syllabus. **Any evidence** of impermissible cooperation on projects, use of disallowed materials or resources, or unauthorized use of computer accounts, **will be** submitted to the Student Honor Council, which could result in an XF for the course, or suspension or expulsion from the University. Be sure you understand what you are and what you are not permitted to do in regards to academic integrity when it comes to project assignments. These policies apply to all students, and the Student Honor Council does not consider lack of knowledge of the policies to be a defense for violating them. Full information is found in the course syllabus, which you should review before starting.

<!-- Link References -->

<!-- TODO: Add actual cloning directions -->
[cloning instructions]: ../git_cheatsheet.md
[submit server]: https://submit.cs.umd.edu/
[gradescope server]: https://www.gradescope.com
[web submit link]: image-resources/web_submit.jpg
[web upload example]: image-resources/web_upload.jpg
