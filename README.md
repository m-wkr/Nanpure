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

## How do I compile this?

In order to compile this project, you must be operating on an Arm64 and Linux environment. If you do not have access to these, you 
may wish to seek out an emulator like [QEMU](https://www.qemu.org/).
1. Clone the repository: `git clone https://github.com/m-wkr/Nanpure`
2. Move into the cloned directory: `cd Nanpure`
3. Run `as -o <yourObjectNameHere> main.s && ld -o <execName> <yourObjectNameHere>` to create the executable.
4. Ensure your executable has the correct permission, then run `./<execName>`

## Screenshot

| |
| - |
|![](/assets/screenshot.png) |
