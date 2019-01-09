## v1.0.3 / 2019 Jan 9

> This release is the first _Climate_ release of the forked `zoid-demo` from
> the PayPal [work](https://medium.com/@bluepnume/introducing-paypals-open-source-cross-domain-javascript-suite-95f991b2731d).
> We have started with a few clean-ups, and added in the `npm` tasks to bump
> the version of the project, and add in the templated section to the
> `CHANGELOG.md` file in the project. This makes it so easy to bump the version
> and write the notes for this release.
>
> In the coming days, we will be adding the Legoland deployment capabilities
> so that this is a complete _forkable_ base project for this `zoid` work.

* **Add** - added the `npm run version:major` scripts to be able to easily
  bump the version number of the project, and add the `CHANGELOG.md` section
  for the description of what's been done.
* **Add** - added more to the `README.md` to indicate how to use the above
  scripts to bump the version.
* **Update** - moved the `publish.sh` script into `./bin` where all the other
  scripts will be living. This included changing the targets in the
  `package.json` file.

```html
  <!-- Pull in zoid and component we defined -->
  <script src="login-zoid-component.frame.js"></script>
```
