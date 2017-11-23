#!/bin/bash

cp /etc/gitlab/gitlab.rb /etc/gitlab/gitlab.rb.old

#Configue HPE STMP RELAY smtp1.hpe.com 25
sed -i -e '/\bsmtp_enable\b/s/^# //' /etc/gitlab/gitlab.rb
sed -i -e '/\bsmtp_address\b/s/^# //' -e 's/"smtp.server"/"smtp1.hpe.com"/' /etc/gitlab/gitlab.rb
sed -i -e '/\bsmtp_port\b/s/^# //' -e 's/ = 465/ = 25/' /etc/gitlab/gitlab.rb
sed -i -e '/\smtp_domain\b/s/^# //' -e 's/example.com/hpe.com/' /etc/gitlab/gitlab.rb
sed -i -e '/\smtp_enable_starttls_auto\b/s/^# //' /etc/gitlab/gitlab.rb
sed -i -e '/\smtp_tls\b/s/^# //' /etc/gitlab/gitlab.rb
sed -i -e '/\gitlab_email_enabled\b/s/^# //' /etc/gitlab/gitlab.rb
sed -i -e '/\gitlab_email_from\b/s/^# //' -e 's/example@example.com/gitlab.shared.bsa.lab@hpe.com/' /etc/gitlab/gitlab.rb
sed -i -e '/\gitlab_email_reply_to\b/s/^# //' -e 's/noreply@example.com/noreply.gitlab.shared.bsa.lab@hpe.com/' /etc/gitlab/gitlab.rb
sed -i -e '/\gitlab_email_display_name\b/s/^# //' -e "s/= 'Example'/='CAM Shared GitLab'/" /etc/gitlab/gitlab.rb

gitlab-ctl reconfigure