# Drone — CI/CD Automation Pipeline

Automated build, test, and deployment pipelines for Omarchy themes and tools.
GitHub Actions, local Git hooks, and release automation.

## Structure

```
drone/
├── pipelines/           # Pipeline definitions
│   ├── theme-test.yml   # Theme validation pipeline
│   ├── theme-publish.yml # Theme release pipeline
│   └── tool-build.yml   # Tool build & test pipeline
├── actions/             # Custom GitHub Actions
│   ├── validate-theme/  # Theme validation action
│   └── extract-assets/  # Asset extraction action
└── deploy/              # Deployment targets
    ├── aur.sh           # AUR package deploy
    └── pages.sh         # GitHub Pages deploy
```
