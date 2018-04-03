name 'grafana-graphite-server'
maintainer '7digital'
maintainer_email 'tech-team@7digital.com'
license 'MIT'
description 'Installs Grafana & Graphite'
long_description 'Runs them via Docker'
version '5.0.4' # update in the graphite integration test as well

supports 'debian'

depends 'docker', '~> 4.0.1'

chef_version '>= 12.15' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/grafana-graphite-server-cookbook/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/grafana-graphite-server-cookbook'
