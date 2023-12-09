# Gim -- Git for Mortals

Gim is a “porcelain” for Git.

## Status

Pre-alpha.

## Architecture

Gim is written in Perl, which is a dependency of Git itself, so a
Perl interpreter is always available where Git is running.

To make Gim easily accessible even to users not familiar with the
Perl environment (which is only rudimentary on some platforms like
Git Bash for Windows), Gim is being shipped as one monolithic file
instead of a Perl module to be installed via CPAN.

Some necessary modules are downloaded on first use if they are not
available, and installed in ~/.config/gim/perl5.

## Quick Start

Put the ‘gim’ script somewhere into your PATH, then call ‘gim help
topics’ to see an overview of Gim's concepts. ‘gim help’ will give
you a list of the available commands.
