
## How to release a version

- Create & push a release branch `release/vA.B.C` -> the prepare_release action will automatically create the PR to merge this release into master and develop.
- Run `bundle exec fastlane prepare_release` to update the changelog and Podfile.lock
- Merge the PR into master -> the CI action will trigger a pod release and tag the commit
- Once the PR into master is merged, merge the branch `release/vA.B.C` into develop
