#!/bin/sh -e

###
# File     : postgresql.sh
# License  :
#   Copyright (c) 2017 Herdy Handoko
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
# Notes    :
#   Based on the following Open Source projects
#   - https://github.com/jackdb/pg-app-dev-vm/
###

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
# Database names
APP_DB_NAME_DEV=${APP_DB_NAME}_dev
APP_DB_NAME_TEST=${APP_DB_NAME}_test



# -----------------------------------------------------------------------------
# Provisioning Summary Output
# -----------------------------------------------------------------------------
print_summary () {
  echo "Your PostgreSQL database has been setup and accessible on the forwarded port (default: 15432)"
  echo "  Host           : $HOST_IP"
  echo "  Port           : 5432"
  echo "  Username       : $APP_DB_USER"
  echo "  Password       : $APP_DB_PASS"
  echo "  Database (Dev) : $APP_DB_NAME_DEV"
  echo "  Database (Test): $APP_DB_NAME_TEST"
  echo ""
  echo "Admin access to postgres user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo ""
  echo "psql access to app database user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h $HOST_IP $APP_DB_NAME_DEV"
  echo ""
  echo "Env variable for application development:"
  echo "  DATABASE_URL=postgresql://$APP_DB_USER:$APP_DB_PASS@$HOST_IP:5432/$APP_DB_NAME_DEV"
  echo ""
  echo "Local command to access the database via psql:"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h $HOST_IP -p 5432 $APP_DB_NAME_DEV"
}



# -----------------------------------------------------------------------------
# Provisioning Script
# -----------------------------------------------------------------------------
export DEBIAN_FRONTEND=noninteractive

# Exit script if already provisioned
PROVISIONED_ON=/etc/vm_provision_on_timestamp
if [ -f "$PROVISIONED_ON" ]
then
  echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
  echo "To run system updates manually login via 'vagrant ssh' and run 'apt-get update && apt-get upgrade'"
  echo ""
  print_db_usage
  exit
fi

# Add PostgreSQL to the package sources
PG_REPO_APT_SOURCE=/etc/apt/sources.list.d/pgdg.list
if [ ! -f "$PG_REPO_APT_SOURCE" ]
then
  # Add PG apt repo:
  echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > "$PG_REPO_APT_SOURCE"

  # Add PGDG repo key:
  wget --quiet -O - https://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
fi

# Update package list and upgrade all packages
apt-get update
apt-get -y upgrade

# Install PostgreSQL
apt-get -y install "postgresql-$PG_VERSION" "postgresql-contrib-$PG_VERSION"

# Configure PostgreSQL
PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Append to pg_hba.conf to add password auth:
echo "host    all             all             all                     md5" >> "$PG_HBA"

# Explicitly set default client_encoding
echo "client_encoding = utf8" >> "$PG_CONF"

# Restart so that all new config is loaded:
service postgresql restart

# Create users and database
cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS' CREATEDB;

-- Create the test database:
CREATE DATABASE $APP_DB_NAME_TEST WITH OWNER=$APP_DB_USER
                                  LC_COLLATE='en_US.utf8'
                                  LC_CTYPE='en_US.utf8'
                                  ENCODING='UTF8'
                                  TEMPLATE=template0;

-- Create the database:
CREATE DATABASE $APP_DB_NAME_DEV WITH OWNER=$APP_DB_USER
                                 LC_COLLATE='en_US.utf8'
                                 LC_CTYPE='en_US.utf8'
                                 ENCODING='UTF8'
                                 TEMPLATE=template0;
EOF

# Tag the provision time:
date > "$PROVISIONED_ON"

# Print out success and summary message
echo "Successfully provisioned PostgreSQL."
echo ""
print_summary
