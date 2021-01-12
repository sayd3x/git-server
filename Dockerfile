FROM alpine:latest

ADD startup.sh /usr/local/bin
RUN apk add --update openssh-server git && \
	echo "Ensure to be accessed using publickey only" && \
	echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
	chmod +x /usr/local/bin/startup.sh && \
	rm -rf /tmp/* /var/cache/apk/*

RUN echo "Setup git user" && \
	adduser git -D && \
	sed -i 's/^git:!:/git:\*:/g' /etc/shadow && \
	sed -i 's/:\/home\/git:.*/:\/home\/git:\/usr\/bin\/git-shell/g' /etc/passwd && \
	mkdir /home/git/.ssh && \
	touch /home/git/.ssh/authorized_keys && \
	chown git:git -R /home/git/.ssh && \
	chmod 700 /home/git/.ssh && \
	chmod 600 /home/git/.ssh/authorized_keys && \
	echo "Setup gitadmin user" && \
	adduser gitadmin -D && \
	sed -i 's/^gitadmin:!:/gitadmin:\*:/g' /etc/shadow && \
	addgroup gitadmin git && \
	mkdir /home/gitadmin/.ssh && \
	touch /home/gitadmin/.ssh/authorized_keys && \
	chown gitadmin:gitadmin -R /home/gitadmin/.ssh && \
	chmod 700 /home/gitadmin && \
	chmod 700 /home/gitadmin/.ssh && \
	chmod 600 /home/gitadmin/.ssh/authorized_keys && \
	echo "Create repository directory" && \
	mkdir /repos && \
	chown gitadmin:git -R /repos

ENTRYPOINT ["/usr/local/bin/startup.sh"]
CMD ["/usr/sbin/sshd","-e","-D"]

EXPOSE 22
