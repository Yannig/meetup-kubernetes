mhsendmail:
	wget https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 -O mhsendmail
	chmod +x mhsendmail

demo-storage:
	kubectl apply -f storage/

delete-deployment:
	kubectl delete deployment mailhog

port-forward:
	kubectl port-forward deployment/mailhog 1025 8025

send-mail: mhsendmail
	cat email.txt | ./mhsendmail --smtp-addr="0.0.0.0:1025" test@mailhog.local
