# AdvCmd
My personal version of an advanced command prompt on Windows

## Advantages

* Run and shell integration;
* Pre-set quoted variables for file path and name (see Usage);
* Possibility to define alias (see Usage);
* Optimized paste and duplicate/quit prompt operations;
* Optionally, a Matrix style colored prompt :)


## Installation

1. Clone this repository;
2. Copy AdvCmd folder in a path without spaces on your drive, and open it;
3. Run AdvCmd_shell_register.bat as administrator;
4. Optionally, run also SetMatrixStyle.bat;
5. Open AdvCmd.exe properties and enable execution as administrator in Compatibility tab.


## Usage

You can:

open AdvCmd from context menu, menu bar and run dialog (win+r);

use ctrl+v to paste, alt+f4 and alt+x to quit, and alt+d to open a new prompt;

if, for example, you installed ffmpeg, and open AdvCmd on test.avi file, you can write:

`ffmpeg -i %f% %n%.mp3`

(note: pre-set variables is case insensitive)

define an alias for a command, for example (if you have installed git and this is in system PATH):

`alias add clone "git clone"`

and then (after AdvCmd restart), write:

`clone https://github.com/ABuffEr/AdvCmd.git`

or perhaps pre-set switches for a command (already included):

`alias add dir "dir /b /o:g"`

(see alias without arguments for help);

run some useful batch (located in Utils folder), such as MyIP (to get your Internet IP), Add2Run (to add voices callable from Run dialog) and HideBatch (to generate a .vbs that hides specified .bat execution).
