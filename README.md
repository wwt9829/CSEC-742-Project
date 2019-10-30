# CSEC-742-Project
**Attack Defend Exercise for Computer System Security (RIT CSEC-742)**

**Gain understanding and experience with vulnerabilities and exploitation**

Construct a vulnerable system for others to attack and configure a monitoring system to observe attacks. Set up a VM, configure it to be susceptible to an exploit, and connect it to the private subnet in the RIT Virtual Lab Environment. Attack other students' infrastructures to discover their vulnerabilities, observe attacks against your infrastructure, and create offensive and defensive reports reviewing the techniques you used or observed.

## Timeline
- Part 1: Exploit working (11/1)
- Part 2: Monitoring working (11/11)
- Part 3: Competition (11/13-11/25)
- Part 4: Writeups - Offensive and Defensive (11/29)
- Part 5: Comments and feedback for classmates (12/9)

## Exploit Overview
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Shellshock-bug.png/1024px-Shellshock-bug.png" alt="Shellshock Logo" width="100"/>

**[Shellshock (CVE-2014-6271)](https://www.exploit-db.com/exploits/34765)**

Shellshock is a group of security bugs in Unix’s default Bash (Bourne-Again) shell which allow for a user to run arbitrary code on vulnerable devices that they can connect to. These vulnerabilities were discovered between September 12th and September 24th, 2014 with patches being co-developed by vulnerability researchers and the Bash maintainers prior to disclosure.  The initial discovery showed that Bash would unintentionally execute commands when they were concatenated to the end of function definitions stored in the values of environment variables. There were many ways that the bug could be leveraged, including via the internet through unpatched web servers, SSH servers, DHCP clients, and mail servers. Attackers began exploiting Shellshock within hours of disclosure, attacking various entities such as Akamai, Yahoo!, and the United States Department of Defense.

## Implementation Details

### Docker-Compose:
[Docker Hub](https://hub.docker.com/r/wwt92829/csec-472-project)
```
version: '3'

services:

  server:
    image: wwt92829/csec-472-project
    container_name: server
    ports:
      - "80:80"
```
1. Download a vulnerable version of Bash (this image uses 4.2) from [GNU's website](http://ftpmirror.gnu.org/bash/).
2. Create a web server (this image uses Apache httpd)
3. Create and frame a shell script with `Content-type: text/html` in an HTML file. The shell script should be stored...
