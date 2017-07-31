# tzselect-formula


## TL;DR


Set a pillar with the timezone, as shown in pillar.example.  Several files are changed to set a default TZ variable for all processes.  This reduces systemcalls and thereby latency, particularly in certain environments.  You must _reboot_ to affect the change.


## Instructions

This formula is intended for virtualization environments or where you need to reduce context swithes. You can read about challenges with the gettimeofday systemcall here: [TZ vs Systemcalls](https://blog.packagecloud.io/eng/2017/02/21/set-environment-variable-save-thousands-of-system-calls/),  [Systemcalls on AWS](https://blog.packagecloud.io/eng/2017/03/08/system-calls-are-much-slower-on-ec2/)

You can discover your own preferred timezone string via `tzselect` which is available in nearly every distribution of Linux.  ([addt'l ref:](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) )

Setup pillar data for each system with the Timezone string.  Associate it with your top file in your pillar data.

Example

     timezone:
       environment: US/Pacific


Then call the tzselect state

     salt-call state.sls tzselect


or from the salt master

     salt '*' state.sls tzselect


This will apply changes which will allow all shells, and all systemd processes, to get a fixed Environment-variable with the system timezone _after you reboot_. 
