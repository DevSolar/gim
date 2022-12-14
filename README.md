gim -- Git for Mortals
----------------------

Gim is a "porcelain" for Git.

There are many graphical clients and IDE plugins for Git available. Gim
tries to be the _command line_ experience you would enjoy working with as
a developer.

Gim provides only a subset of the options and features offered by Git.
The idea was to exchange flexibility for conciseness, a pleasant user
experience for those looking to “just check in my work” as opposed to
full-time repository maintainers Git itself is geared towards.

It was inspired by Elijah Newren's EasyGit, but is a wholly separate work.

Status
------

Very much pre-pre-alpha. Many subcommands are mere dummys at this point,
and very important stuff (like merging) is missing completely.

I uploaded the sources for some early review by a friend.

"Installation"
--------------

Check out somewhere and add to your PATH.

Run ‘gim devel completion’ to get a bash completion script (to put in
/etc/bash_completion.d/ or ~/.local/share/bash-completion/completions).
