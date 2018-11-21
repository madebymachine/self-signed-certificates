# Contributor guidelines

This project uses [GitHub Flow](https://guides.github.com/introduction/flow/).
The `master` branch should always be stable. Changes should be made on separate
branches, and applied via pull requests.

## Pull request etiquette

Before opening a pull request, you should rebase your branch onto the `master`
branch first. If you're not familiar with this approach, please read <https://www.atlassian.com/git/tutorials/merging-vs-rebasing>.

This will help keep the commit history clean, making for easier code review. It
also gives you a chance to review your proposed changes in light of more recent
work that may have already been committed to the `master` branch.

You may also wish to perform an interactive rebase to squash or fixup many small
commits into fewer, larger ones. That said, you should keep logically separate
changes in separate commits so that they can be reverted more easily if
necessary.

## Branch naming

Branch names should adhere to the following format:

`<owner>/<type>/<description>`

E.g. A developer named Art Vandelay, working on a latex sales feature, should
name his branch `art-vandelay/feat/latex-sales`.

N.b. Where appropriate, it is helpful to use a Conventional Commit type value
for the `type` segment (see [Commit message format](#commit-message-format)).

## Commit message format

Commit messages should adhere to the following format:

```
<type>[(<scope>)]: <description>

[<optional body>]

[<optional footer>]
```

The first line of a commit message should be written in the imperative present
tense, and in lower case, and should not exceed 50 characters in length.

The body and footer, if present, should be written in sentence case, and each
line should not exceed 80 characters in length.

### Example

```
feat(sales): add latex sales support

Add 'latex' product type, pricing data, and associated business logic.

Closes #42
```

Acceptable values for the `type` segment:

- `build`
- `chore`
- `ci`
- `docs`
- `feat`
- `fix`
- `perf`
- `refactor`
- `revert`
- `style`
- `test`

The `scope` value is freeform, but should be written in lower-kebab-case.

This style is compatible with the
[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0-beta.2/)
standard.
