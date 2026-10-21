# compliance-trestle-template-component-definition

compliance-trestle repository for agile authoring of component-definition

Prerequisite: [component-definition template](https://github.com/IBM/compliance-trestle-template-component-definition) has been used to create repo for [agile authoring](https://github.com/IBM/compliance-trestle-agile-authoring).

##### downstream system-security-plan update

After a release on `main`, CI runs `scripts/automation/update_downstream.sh` to sync assembled component-definitions into the configured downstream system-security-plan repository.

That script keeps a single open PR against `develop` on the fixed branch `components_autoupdate`:

- **No open PR** — reset the branch from `develop`, push it, and open a new PR.
- **Open PR already exists** — commit on top of that branch and push so the new component sync is bundled into the existing PR (instead of opening another PR per run).

Once the PR is merged, the next sync with no open PR starts fresh from `develop` again.

______________________________________________________________________

We are a Cloud Native Computing Foundation sandbox project.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://www.cncf.io/wp-content/uploads/2022/07/cncf-white-logo.svg">
  <img src="https://www.cncf.io/wp-content/uploads/2022/07/cncf-color-bg.svg" width=300 />
</picture>

The Linux Foundation® (TLF) has registered trademarks and uses trademarks. For a list of TLF trademarks, see [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage).

*OSCAL Compass is an independent open source project. It is not affiliated with, endorsed by, or sponsored by the National Institute of Standards and Technology (NIST) or any other government agency.*

*OSCAL Compass was originally contributed by IBM.*
