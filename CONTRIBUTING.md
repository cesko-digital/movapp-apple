# Before you continue reading this content please read first our [Movapp CONTRIBUTING.MD](https://github.com/cesko-digital/movapp/blob/ed0d95a196568e9055c5f4ca347647cfed790aae/CONTRIBUTING.md)


# Additional information specific to this repository

## Table of Contents
- [Your First Code Contribution](#your-first-code-contribution)
- [Styleguides](#styleguides)
- [Automatization](#automatization)
- [Signing](#signing)
- [Releasing](#releasing)

## Your First Code Contribution
> Inherited from [Movapp CONTRIBUTING.MD Your First Code Contribution](https://github.com/cesko-digital/movapp/blob/ed0d95a196568e9055c5f4ca347647cfed790aae/CONTRIBUTING.md#your-first-code-contribution)
- During development, add information about the updates to the [CHANGELOG.md](CHANGELOG.md) file in the `[Unreleased]` section. If something is missing in it before the release, please complete and commit it.

## Styleguides
### Code quality
We are using the [swiftlint](https://github.com/realm/SwiftLint) in build phase of the project and as quality gate for pull requests. 

Install it locally 
```bash 
brew install swiftlint
```
#### Quality gate for pull requests
- Swiftlint runs as [Github Action](./.github/workflows/swiftlint.yml) that inform you in PR about issues in your changes.

## Automatization

For automatization we are using [Fastlane](https://fastlane.tools) that save us a lot of time 🕕. You don't need it run locally.
<details>
  <summary>Installation guide</summary>

- Installation via `bundle` (Recommended because everyone will use the same version)
```bash
cd movapp-apple
bundle install
```

- Installation via `brew`
```bash
brew install fastlane
```
</details>

### Updating content (Dictionary, Alphabet, Stories, etc.)

The content of the application is defined in [movapp-data](https://github.com/cesko-digital/movapp-data) repository. Every time somebody make a change it will trigger [Github Action data update](.github/workflows/data-update.yml) that will create a pull request with changes. This pull request is handed as pull request from anybody else.

## Signing

You don't need to worry about it locally.
<details>
    <summary>If you need it locally</summary>

```bash
bundle exec fastlane match development --readonly
```
</details>

<details>
    <summary>Certificate expired</summary>

- You need to have access to repository defined in [Matchfile](/Fastlane/Matchfile)
- Then run

```bash
bundle exec fastlane nuke
bundle exec fastlane match development
```
</details>

### Releasing
#### Releasing to TestFlight

The release process is almost all automatized via fastlane. You just need to run [Github Action Release](.github/workflows/release.yml) manually. This action will:
- increase the app version
- mark `[UNREALEASED]` changes as released in [CHANGELOG.md](/CHANGELOG.md)
- commit those changes to `main` and tag it with correct version

Tagging a main will trigger [Github Action Deploy](.github/workflows/deploy.yml). This action will:
- build the application and upload it to the TestFlight
- capcure screenshots via [Fastlane Snapfile](Fastlane/Snapfile)
- upload screenshots and metadata to AppStore
- upload screenshots to [Github Pages](https://cesko-digital.github.io/movapp-apple/screenshots.html)

#### Releasing to AppStore

Once the team agrees on releasing the application to the AppStore we follow following steps:
- Get a release notes from Slack
- AppStore Connect
    - add release notes
    - select the latest version uploaded to TestFlight
    - send to Apple Review with automatically releasing
- Increase the version of the application via [Github Action Bump version](.github/workflows/bump_version.yml)

