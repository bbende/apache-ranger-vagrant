# apache-ranger-vagrant

Provisions a CentOS7 VM, installs JDK8, MariaDB/MySQL, and installs Apache Ranger Admin Webapp.

Requires having the Apache Ranger code cloned and built outside of this project.

## Setup

1. Install VirtualBox

    [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

2. Install Vagrant

    [https://www.vagrantup.com/](https://www.vagrantup.com/)

3. Clone this repository

        git clone https://github.com/bbende/apache-ranger-vagrant.git

4. Create ranger-env.sh

        cd apache-ranger-vagrant
        cp scripts/ranger-env.sh.example scripts/ranger-env.sh

5. Edit scripts/ranger-env.sh and set RANGER_HOME to point the root of range source code (requires having previously performed a full build with artifacts in RANGER_HOME/target).

(Optional) If you want to install Solr to use for Ranger auditing, first download the [Solr 5.5.1](http://archive.apache.org/dist/lucene/solr/5.5.1/) tgz to your local computer, then edit ranger-env.sh and set INSTALL_SOLR=true and set SOLR_TAR to the full path to solr-5.5.1.tgz.

6. Launch the VM

        ./scripts/up.sh

7. Wait until the log shows output similar to the following:

        INFO: Initializing Spring root WebApplicationContext
        Mar 28, 2016 1:40:42 PM com.sun.jersey.api.core.PackagesResourceConfig init
        INFO: Scanning for root resource and provider classes in the packages:
          org.apache.ranger.rest
          org.apache.ranger.common
          xa.rest
        Mar 28, 2016 1:40:43 PM com.sun.jersey.api.core.ScanningResourceConfig logClasses
        INFO: Root resource classes found:
          class org.apache.ranger.rest.ServiceREST
          class org.apache.ranger.rest.TagREST
          class org.apache.ranger.rest.UserREST
          class org.apache.ranger.rest.XAuditREST
          class org.apache.ranger.rest.XUserREST
          class org.apache.ranger.rest.PublicAPIsv2
          class org.apache.ranger.rest.AssetREST
          class org.apache.ranger.rest.XKeyREST
          class org.apache.ranger.rest.PublicAPIs
        Mar 28, 2016 1:40:43 PM com.sun.jersey.api.core.ScanningResourceConfig logClasses
        INFO: Provider classes found:

8. Navigate to [http://localhost:6080/index.html](http://localhost:6080/index.html) in your browser and login with admin/admin

9. Destroy the VM when Done

        ./scripts/destroy.vm

## Redeploy Admin WebApp

To deploy the latest admin webapp while the VM is already running:

        ./scripts/redeploy.sh

## Troubleshooting

To ssh on to the machine:

        vagrant ssh

Ranger Admin logs are located at:

        sudo tail -n 200 -f /var/log/ranger/admin/catalina.out

Ranger is installed under:

        /vagrant/stage/ranger-<VERSION>-admin/

Solr runs on port 6083 and should be accessible outside the VM at:

        http://localhost:6083/solr

Solr logs are located at:

      sudo tail -n 200 -f /var/log/solr/ranger_audits/solr.log
