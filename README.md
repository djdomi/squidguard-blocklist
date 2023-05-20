# squidguard-blocklist
Scripts and some other things


its basically good to run it once a week on /etc/cron.weekly as most of the sites wont change
Moreover the Script should be 100% silent, if its output something, then there must me something horribly gone wrong ;D



# howto install?
Copy this script into /etc/cron.weekly
It does not make sense, to run it more often, due the changes are not often


#What does it?
it catches from serval sources the hosts file formatted files and convert it into domain names only
this can be used either by 

## SquidGuard
> edit the SCript and change it to:
```
PATH2=/var/lib/squidguard/db/BL/BadSites
FILE2=domains
```
 
> edit /etc/squidguard/squidguard.conf
```
dest BadSites        {  
                      domainlist      BL/BadSites/domains  
}  
```
and dont forget to add !BadSites to the rules of your clients

```
acl {
        admin {
                pass     any !BadSites
                redirect https://blocked.ccb-net.it/blocked.cgi?clientaddr=%a&clientname=%n&clientuser=%i&clientgroup=%s&targetgroup=%t&url=%u
        }

        default {
                pass !BadSites any
                redirect https://blocked.ccb-net.it/blocked.cgi?clientaddr=%a&clientname=%n&clientuser=%i&clientgroup=%s&targetgroup=%t&url=%u
        }
}
```

### SquidGuards needs one extra Step
```
squidGuard -b -C all
```

if done Correctly `/var/log/squidguard` should tell INFO: squidGuard ready for requests else it will tell `Going into emergency mode` and have to see in `/var/log/squid/cache.log` - mostly its  permission issue which can be fixed with `chown proxy:proxy -R /var/lib/squidguard/db` - remind this usually is working for debian based, but could be other on your distribution

  
## Squid ACL

> Edit the Script and change it to:
```
PATH2=/etc/squid
FILE2=BadSites
```

> /etc/squid/squid.conf
```
acl BadSites dstdomain "/etc/squid/BadSites"
http_access deny BadSites
```


## Test Configuration and reload Squid to apply. You usually only need one solution, but both can work in coexistance.

> squid -k parse - verify if an error is occuring if not
> /etc/init.d/squid reload



