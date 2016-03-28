# apache-ranger-vagrant

Deploys Apache Ranger in a Vagrant VM using the Ranger artifacts built from source.

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

8. Navigate to [http://localhost:6080/index.html](http://localhost:6080/index.html) in your browser

9. Destroy the VM when Done

        ./scripts/destroy.vm
