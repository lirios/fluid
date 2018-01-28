# How to contribute

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

These are the general rules for contributing to any Liri repositories, which are hosted
in the [Liri Organization](https://github.com/lirios) on GitHub.

These are mostly guidelines, not rules. Use your best judgment, and feel free to propose
changes to this document in a pull request.

First of all we need you to sign the Contributors License Agreement for all non trivial contributions.
Please read more [here](https://liri.io/org/cla/).

#### Table Of Contents

[Code of Conduct](#code-of-conduct)

[I don't want to read this whole thing, I just have a question!!!](#i-dont-want-to-read-this-whole-thing-i-just-have-a-question)

[How Can I Contribute?](#how-can-i-contribute)
  * [Reporting Bugs](#reporting-bugs)

[Style Guides](#styleguides)
  * [Git Commit Messages](#git-commit-messages)
  * [C++ and QML](#c++-and-qml)

[Additional Notes](#additional-notes)
  * [Issue and Pull Request Labels](#issue-and-pull-request-labels)

## Code of Conduct

This project and everyone participating in it is governed by the [Liri Code of Conduct](https://liri.io/community/code-of-conduct/).

By participating, you are expected to uphold this code.
Please report unacceptable behavior to [info@liri.io](mailto:info@liri.io).

## I don't want to read this whole thing I just have a question!!!

> **Note:** Please don't file an issue to ask a question. You'll get faster results by using the resources below.

* [Chat via Matrix](https://matrix.to/#/#liri:matrix.org)
* [IRC channel](http://webchat.freenode.net/?channels=%23liri&uio=d4)
* [Reddit](https://www.reddit.com/r/liri/)
* [Google+ Community](https://plus.google.com/communities/115722443491803015565)

## How Can I Contribute?

### Reporting Bugs

Users are encouraged to take care of following aspects while reporting issues.

#### 1. Be gentle

We are volunteers, most of us work on our spare time primarily because we enjoy it.
Please be gentle, it's often difficult to set deadlines in stone for new releases
or bug fixes. If you are in hurry and have skills to program, please consider
contributing code and documentation.

#### 2. Do not say "it's not working"

Developers are inherently objective and analytical. If the software is not behaving
as expected, please *explain in details* what is actually happening.
It is useless to just say it's not working. Eg if you are seeing a blank screen,
do not say you are seeing "nothing" it better to say you are seeing a blank screen.

#### 3. Make no implicit assumption

If you are stating something be very sure about it, if you are *thinking* 
or assuming something make it clear that you assumed something.

#### 4. Give specific examples *even* if you are referring to an universal set

If a bug exists for a collection of input factors, try to give specific
instances of the input. Eg suppose a thing does not work for any of the users, 
you should report that "it did not work for any of the users and we tested it
for sam and joe".

#### 5. Choose a proper subject

Choosing a proper subject allows us to make a mental map when we glance 
over a list. We are quickly able to think about dependencies and priorites
in a glance.

* A proper subject should be a one liner preferably less than 80 chars.
* It should indicate the extent of the problem.
* It should summarize as comprehensive as possible.

#### 6. Provide a minimal replication procedure

Replicating a bug is a demanding activity.

Mention all the steps that are necessary to repeat the problem.

Also attach a compressed minimal program source code to reproduce the
problem, complete with information about your development environment.
   
#### 7. Provide details and evidence
  
It helps greatly to attach screenshots and videos of a problem specially
when you are referring to visual issues.

#### 8. Keep the developers updated of any new observation regarding the issue

Please report new observations as you find them.
Every bit of information helps since it is often difficult to give immediate
response.
   
#### 9. Report-back workarounds

If you find a workaround for a issue please update the report indicating it
so that others can use it temporarily. It greatly helps developers also
as sometimes the workaround can be precursors of the formal solutions.

#### 10. Report software versions, setup, tool chains, etc...

Report what Qt version you are using, operating system (Android, Windows, Linux) and
your environment in general.

## Style Guides

### Git Commit Messages

Write [good commit messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) and
use the [git flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model.

### C++ and QML

All code follows the following coding style and conventions, please read:

* [Qt C++ Coding Conventions](https://wiki.qt.io/Coding_Conventions)
* [Qt C++ Coding Style](https://wiki.qt.io/Qt_Coding_Style)
* [QML Coding Conventions](https://liri-dev.readthedocs.io/en/latest/contributing/coding-conventions/qml-conventions/)

## Additional Notes

### Issue and Pull Request Labels

This section lists the labels we use to help us track and manage issues and pull requests.

[GitHub search](https://help.github.com/articles/searching-issues/) makes it easy to use labels
for finding groups of issues or pull requests you're interested in. For example, you might be
interested in [open issues across `lirios` and all Liri-owned packages which are labeled
as bugs, but still need more information](https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Abug+label%3Aneeds-info)
or perhaps [open pull requests in `lirios` which haven't been reviewed yet](https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+user%3Alirios+comments%3A0+).

To help you find issues and pull requests, each label is listed with search links for finding
open items with that label in `lirios/lirios` only and also across all Liri repositories.

We encourage you to read about [other search filters](https://help.github.com/articles/searching-issues/)
which will help you write more focused queries.

The labels are loosely grouped by their purpose, but it's not required that every issue have a label
from every group or that an issue can't have more than one label from the same group.

Please open an issue on `lirios/lirios` if you have suggestions for new labels, and if you notice some
labels are missing on some repositories, then please open an issue on that repository.

#### Type of Issue and Issue State

| Label name | `lirios/fluid` :mag_right: | `lirios`‑org :mag_right: | Description |
| --- | --- | --- | --- |
| `feature` | [search][search-fluid-repo-label-feature] | [search][search-lirios-org-label-feature] | Feature requests. |
| `enhancement` | [search][search-fluid-repo-label-enhancement] | [search][search-lirios-org-label-enhancement] | Improvements over existing features. |
| `easy` | [search][search-fluid-repo-label-easy] | [search][search-lirios-org-label-easy] | Less complex issues which would be good first issues to work on for users who want to contribute to Atom. |
| `bug` | [search][search-fluid-repo-label-bug] | [search][search-lirios-org-label-bug] | Confirmed bugs or reports that are very likely to be bugs. |
| `question` | [search][search-fluid-repo-label-question] | [search][search-lirios-org-label-question] | Questions more than bug reports or feature requests (e.g. how do I do X). |
| `help wanted` | [search][search-fluid-repo-label-help-wanted] | [search][search-lirios-org-label-help-wanted] | The Liri core team would appreciate help from the community in resolving these issues. |
| `duplicate` | [search][search-fluid-repo-label-duplicate] | [search][search-lirios-org-label-duplicate] | Issues which are duplicates of other issues, i.e. they have been reported before. |
| `wontfix` | [search][search-fluid-repo-label-wontfix] | [search][search-lirios-org-label-wontfix] | The Liri core team has decided not to fix these issues for now, either because they're working as intended or for some other reason. |
| `invalid` | [search][search-fluid-repo-label-invalid] | [search][search-lirios-org-label-invalid] | Issues which aren't valid (e.g. user errors). |
| `needs info` | [search][search-fluid-repo-label-needs-info] | [search][search-lirios-org-label-needs-info] | Likely bugs, but haven't been reliably reproduced. |
| `needs reproduction` | [search][search-fluid-repo-label-needs-reproduction] | [search][search-lirios-org-label-needs-reproduction] | Likely bugs, but haven't been reliably reproduced. |
| `needs design` | [search][search-fluid-repo-label-needs-design] | [search][search-lirios-org-label-needs-design] | UI design is required before starting with the implementation. |
| `hacktoberfest` | [search][search-fluid-repo-label-hacktoberfest] | [search][search-lirios-org-label-hacktoberfest] | Issues for [Hacktoberfest][hacktoberfest]. |
| `upstream` | [search][search-fluid-repo-label-upstream] | [search][search-lirios-org-label-upstream] | Issue is caused by an upstream bug. |
| `fixed upstream` | [search][search-fluid-repo-label-fixed-upstream] | [search][search-lirios-org-label-fixed-upstream] | Issues was caused by an upstream bug which is fixed now. |
| `doc` | [search][search-fluid-repo-label-doc] | [search][search-lirios-org-label-doc] | Documentation. |
| `package` | [search][search-fluid-repo-label-package] | [search][search-lirios-org-label-package] | Packaging issue or missing packaging. |
| `idea` | [search][search-fluid-repo-label-idea] | [search][search-lirios-org-label-idea] | Idea that needs further discussion before the implementation. |
| `task` | [search][search-fluid-repo-label-task] | [search][search-lirios-org-label-task] | Task. |

[hacktoberfest]: https://hacktoberfest.digitalocean.com/
[search-fluid-repo-label-feature]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Afeature
[search-lirios-org-label-feature]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Afeature
[search-fluid-repo-label-enhancement]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Aenhancement
[search-lirios-org-label-enhancement]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Aenhancement
[search-fluid-repo-label-easy]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Aeasy
[search-lirios-org-label-easy]: https://github.com/issues?utf8=✓&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Aeasy
[search-fluid-repo-label-bug]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Abug
[search-lirios-org-label-bug]: https://github.com/issues?utf8=✓&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Abug
[search-fluid-repo-label-question]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Aquestion
[search-lirios-org-label-question]: https://github.com/issues?utf8=✓&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Aquestion
[search-fluid-repo-label-help-wanted]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3A%22help+wanted%22
[search-lirios-org-label-help-wanted]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3A%22help+wanted%22
[search-fluid-repo-label-duplicate]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Aduplicate
[search-lirios-org-label-duplicate]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Aduplicate
[search-fluid-repo-label-wontfix]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Awontfix
[search-lirios-org-label-wontfix]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Awontfix
[search-fluid-repo-label-invalid]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Ainvalid
[search-lirios-org-label-invalid]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Ainvalid
[search-fluid-repo-label-needs-info]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3A%22needs+info%22
[search-lirios-org-label-needs-info]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3A%22needs+info%22
[search-fluid-repo-label-needs-reproduction]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3A%22needs+reproduction%22
[search-lirios-org-label-needs-reproduction]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3A%22needs+reproduction%22
[search-fluid-repo-label-needs-design]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3A%22needs+design%22
[search-lirios-org-label-needs-design]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3A%22needs+design%22
[search-fluid-repo-label-hacktoberfest]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Ahacktoberfest
[search-lirios-org-label-hacktoberfest]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Ahacktoberfest
[search-fluid-repo-label-upstream]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Aupstream
[search-lirios-org-label-upstream]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Aupstream
[search-fluid-repo-label-fixed-upstream]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3A%22fixed+upstream%22
[search-lirios-org-label-fixed-upstream]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3A%22fixed+upstream%22
[search-fluid-repo-label-doc]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Adoc
[search-lirios-org-label-doc]: https://github.com/issues?utf8=✓&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Adoc
[search-fluid-repo-label-package]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Apackage
[search-lirios-org-label-package]: https://github.com/issues?utf8=✓&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Apackage
[search-fluid-repo-label-idea]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Aidea
[search-lirios-org-label-idea]: https://github.com/issues?utf8=✓&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Aidea
[search-fluid-repo-label-task]: https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+repo%3Alirios%2Ffluid+label%3Atask
[search-lirios-org-label-task]: https://github.com/issues?utf8=✓&q=is%3Aopen+is%3Aissue+user%3Alirios+label%3Atask
