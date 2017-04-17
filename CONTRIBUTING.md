# Contributing
The easiest way to Contribute is to Fork the Code, make a branch for your Changes, then push your changes (when ready) and make a Pull Request.

The only Guidelines for Contributing are simple
- Make a Pull Request (Or `PR`) for a large amount of changes *before* you Finish them, and mention in your pull request something like `do not merge` to make sure your Incomplete changes are *not* merged to `A-Dev`
- Speaking of `A-Dev`, this Repository uses the [gitflow](https://datasift.github.io/gitflow/IntroducingGitFlow.html), In short:
  - Fork the Repository and make a new Branch based off of `A-Dev` if you are making Major changes (Add items to map, Add new features, etc)
  - if you are making Minor fixes (Fix Xenomorphs randomly teleporting, fix critical bug) base it off the latest release tagged in `master` and make a Pull request to merge it into `hotfix`
  - Make sure to also `git fetch` these new branches and `git checkout` them as local branches, and to also `git pull` from the main Repository, you can do this with the command line with the following commands:
  ```bash
  # Add main Repository as a remote called 'upstream'
  git remote add upstream https://github.com/sshado/Aphelion-Code.git
  # Fetch remote Repositories from main repo
  $ git fetch
  # Checkout remote branch 'A-Dev' and 'hotfix' as local branches
  $ git checkout -b A-Dev upstream/A-Dev
  $ git checkout -b hotfix upstream/hotfix
  # Push branches to your fork (In this case called 'origin')
  $ git checkout A-Dev
  $ git push origin A-Dev
  $ git checkout hotfix
  $ git push origin hotfix
  # And when needed, Pull from upstream
  $ git pull upstream
  ```
## License
Baystation12 is licensed under the GNU Affero General Public License version 3, which can be found in full in LICENSE-AGPL3.txt.

Commits with a git authorship date prior to `1420675200 +0000` (2015/01/08 00:00) are licensed under the GNU General Public License version 3, which can be found in full in LICENSE-GPL3.txt.

All commits whose authorship dates are not prior to `1420675200 +0000` are assumed to be licensed under AGPL v3, if you wish to license under GPL v3 please make this clear in the commit message and any added files.
