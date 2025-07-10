<div align="center">
  <img src="/assets/Nanpure.png" alt="testing">
  <p></p>
  <img src="https://img.shields.io/badge/AssemblyScript-007AAC?logo=assemblyscript&logoColor=fff)" alt="AssemblyBadge">
</div>

<hr>

## Preface

Nanpure is a Sudoku Solver implemented in Aarch64 assembly, utilising no standard libraries and relying solely on system calls to backtrack until a valid
solution is found. 
>Note that Nanpure's chosen solution is not exhaustive, as it chooses one out of potential many solutions. And in turn will fail for unsolvable grid
>configurations.

## What are my options for running this program?

Nanpure supports to ways of inputting values into the sudoku grid. First the manual (tedious) method, then second with the grid.conf file held within the top
level of this directory.

### Manual Method

When running the program, at the first input section, if you type any character that do NOT equal to n, you will brought to the manual input section. At this point,
you will be iteratively queried for the follow information in order:
1. What coordinates (with respect to the grid) does your input value lie on
2. What value (1-9) will you input into your selected coordinates
3. Would you like to continue filling the grid or solve the puzzle

This process iterates until you either terminate the program prematurely, or move onto solving the puzzle.

<br>

### Configuration Grid File Method

Open the grid.conf file within your cloned repository, then alter & save the 9 lines in respect of the configuration you wish to solve.
> Note: There should be no gaps or characters outside of 0-9 within the config file, including spaces. Additionally,
> ensure that the last character on each line is the carriage return character.

<br>

## How do I compile this?

In order to compile this project, you must be operating on an Arm64 and Linux environment. If you do not have access to these, you 
may wish to seek out an emulator like [QEMU](https://www.qemu.org/).
1. Clone the repository: `git clone https://github.com/m-wkr/Nanpure`
2. Move into the cloned directory: `cd Nanpure`
3. Run `as -o <yourObjectNameHere> main.s && ld -o <execName> <yourObjectNameHere>` to create the executable.
4. Ensure your executable has the correct permission, then run `./<execName>`

<br>

## Screenshot

| |
| - |
|![](/assets/screenshot.png) |
