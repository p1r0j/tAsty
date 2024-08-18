# tAsty

*The Alias Supplement ThingY*

**tAsty** is an extension for your `~/.bashrc` file which creates an intuitive and cohesive **bashing** experience. With a focus on productivity and file management, some of **tAsty**'s key features include:

*   ***tBook***. A place to store custom **bash** aliases. Simply run the command `tBo` to view all your current **tickets** (**cd** aliases), **links** (**unison** aliases), and **crafts** (custom aliases).

*   ***tTrash***. Bring trash can functionality to your **bash** shell. **tTrash** works just like your desktop's trash can, with the ability to shred or restore its contents with a single command.

*   ***tPocket***. **tPocket** is a convenient place to store commonly used files/directories. You can copy targets into your **tPocket** for later use, and then paste its contents into a targeted destination. **tPocket** can also be saved, loaded, or its contents shredded with a single command.

*   ***tClip***. **tAsty** also includes its own clipboard. Use **tClip** to quickly copy and append the contents of files viewed with **tView** (see ***tNav***). Additionally, clear the contents, paste to **tNote** (see ***tNote*** next), or open up your **tClip** for editing with a single command.

*   ***tNote***. A simple notepad for convenient note-taking in **bash**. Opens for editing in your preferred command line text editor (`EDITOR=[name]` where *name* is the name of your favorite editor, found in your `~/.bashrc` file). Can also be saved, loaded, or cleared with a single command.

*   ***tNav***. A collection of navigational tools that make file system navigation feel more natural. **tNav** includes tools such as **tView** for viewing the contents of files, directories, and compressed files, **tBack** for quickly navigating to your previous working directory, **tUp** for moving up a specified number of directories, and more.

* ***tFile***. A collection of file management tools. For example, **tSelect** allows management of multiple files/directories simultaneously. Similarly, **tRename** is a bulk rename tool. **tFile** also includes essential tools such as **tWrite**, **tLock**, **tSave**, and much more.

## Installation

1.  In your **bash** shell, navigate to the directory you'd like to store **tAsty** in.

    *   Be sure to choose a *permanent* location, as moving the following download after installation will break **tAsty**.

1.  `git clone https://github.com/p1r0j/tAsty.git`

2.  `cd tAsty`

3.  `./tAsty.sh --setup`

4.  Follow the instructions printed to your terminal. From here, you will simply copy/paste the line that **tAsty setup** provided (i.e. `source /home/tastyUser/Git/tAsty/tAsty.sh`) to the bottom (or some other empty area) of your `~/.bashrc` file.

5.  Finally, run the command `source ~/.bashrc`. Your command prompt should change, signifying a successful installation.

