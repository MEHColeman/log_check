# Notes

## Process
1. Create a ruby project directory from a template I have prepared previously.
2. Update the README with project description, and tweak the template to suit
   this project.
3. Create a feature branch for the first feature: outputting total views.
4. Create a failing test that, once it passes, indicates that the feature is
   complete.
5. TDD through the first stage of the requirements (analysing the log for
   views), creating unit tests for each layer of abstraction until the feature
   test passes and the feature is complete.
6. With the feature complete, I create a -no-ff git merge onto the master
   branch, so that the unit of work required for that feature is clear.
6. Coding exercises are sometimes difficult to pitch correctly. Sometimes the
   objective is to simply demonstrate a sufficiently broad understanding of the
   ruby space, sometimes it is to simulate a real-world task in the workplace.

   As the former, the first feature is complete as per the spec. As the latter,
   you might expect logging, validation, and 'unhappy path' checks. Given
   the notes about making changes if you feel that it would produce a better
   outcome, and the obvious 'IP address' format issue going on, I'll go back and
   at least address that.
   I feel that the style of the script is more like a command line Posix script
   than an application, so I'll not use logger, or create a log file, I'll just
   use stdout and stderr, and exit codes.
8. This is done on a new feature branch.
9. The validation will work as follows:
   Line validation: Every line in the log file must be valid. That is, it must
   be a string, followed by 4 numbers separated by `.`s.
   Any file containing an invalid line will be rejected, and no report created.
   IP validation:
   Normal validation will allow and IP in the format XXX.XXX.XXX.XXX.
   Strict validation will only allow ranges up to 255.255.255.255 without
   leading 0s.
   Invalid IPs will not be counted, but processing will continue.

## Comments

For testing the executable, you could use Open3 to capture stdout and stderr
from a child process, but it's OK as it is.

A `--help` option would be a nice addition.

I would normally have a LOGGER object for logging more details of what's
happening, but this seems more of a command line tool than an application with
it's own log file, so I decided not to. Instead, brief error messages are sent
to STDERR. Using STDERR nearly gave me an aneurysm. Ask me why.

The code analysis metrics look good. Ruby critic complains that parser.rb is
not covered well, but I think this is beacause it is checked via a system call.
There are tests that cover parser.rb's code. I'm not sure how to fix that nicely.
