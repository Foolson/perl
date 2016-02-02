#!/bin/sh

if [ "$1" = "-u" ] ; then
	for service in cyrus-imapd vsftpd named httpd postfix ; do sudo systemctl disable ${service} && sudo systemctl stop ${service} ; done && sudo yum -y remove cyrus-imapd vsftpd bind httpd postfix && sudo yum -y autoremove
	test -f /etc/httpd/conf/httpd.conf.rpmsave && sudo mv /etc/httpd/conf/httpd.conf.rpmsave /etc/httpd/conf/httpd.conf
	test -f /etc/httpd/conf/httpd.conf && sudo sed -i -e 's/Listen\ 0.0.0.0:80/Listen\ 0.0.0.0:80/' /etc/httpd/conf/httpd.conf && sudo restorecon -v /etc/httpd/conf/httpd.conf
	test -f /etc/postfix/main.cf.rpmsave && sudo mv /etc/postfix/main.cf.rpmsave /etc/postfix/main.cf
	test -f /etc/postfix/main.cf && grep -v 'home_mailbox = Maildir/' </etc/postfix/main.cf >/tmp/.main.cf && sudo mv /tmp/.main.cf /etc/postfix/main.cf && sudo chown postfix:postfix /etc/postfix/main.cf && sudo restorecon -v /etc/postfix/main.cf
else
	sudo yum -y update && sudo yum -y install cyrus-imapd vsftpd bind httpd openssh-server postfix && sudo sed -i -e 's/Listen\ 80/Listen\ 0.0.0.0:80/' /etc/httpd/conf/httpd.conf && grep -v 'home_mailbox = Maildir/' </etc/postfix/main.cf >/tmp/.main.cf && echo "home_mailbox = Maildir/" >>/tmp/.main.cf && sudo mv /tmp/.main.cf /etc/postfix/main.cf && sudo chown postfix:postfix /etc/postfix/main.cf && sudo restorecon -v /etc/postfix/main.cf && for service in cyrus-imapd vsftpd named httpd sshd postfix ; do sudo systemctl enable ${service} && sudo systemctl --no-ask-password restart ${service} ; done
fi
