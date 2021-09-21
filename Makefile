# Must have `sentry-cli` installed globally
# Following variables must be passed in

SENTRY_AUTH_TOKEN=1c2858efe139473aae8d277f3739fb409d16aab986174680a7d15f8469f7c7b6
SENTRY_ORG=cqupt-5h
SENTRY_PROJECT=js_test

REACT_APP_RELEASE_VERSION=9c18ca179710d1d51863646514bf0b199d684292

setup_release: create_release upload_sourcemaps associate_commits

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(REACT_APP_RELEASE_VERSION)

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(REACT_APP_RELEASE_VERSION) \
		upload-sourcemaps --url-prefix "~/static/js" --validate build/static/js

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(REACT_APP_RELEASE_VERSION)