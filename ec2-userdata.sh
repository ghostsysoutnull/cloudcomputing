#!/bin/bash
sudo yum install -y java-17
sudo yum install -y tomcat9
sudo systemctl start tomcat9
sudo mkdir -p /var/lib/tomcat9/webapps/ROOT
sudo curl -o /var/lib/tomcat9/webapps/ROOT/index.jsp -L "https://raw.githubusercontent.com/ghostsysoutnull/cloudcomputing/main/index.jsp"
sudo chmod 644 /var/lib/tomcat9/webapps/ROOT/index.jsp
sudo systemctl restart tomcat9
sudo systemctl enable tomcat9
