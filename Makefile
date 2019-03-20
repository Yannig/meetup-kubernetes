# Test réalisé avec Minikube
MHSENDMAIL_URL ?= https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64

mhsendmail:
	wget $(MHSENDMAIL_URL) -O mhsendmail
	chmod +x mhsendmail

deploy-mailhog:
	cat mailhog/* | sed "s/IP_MINIKUBE/$$(minikube ip)/" | kubectl apply -f -

port-forward:
	kubectl port-forward deployment/mailhog 1025 8025

send-mail: mhsendmail
	cat email.txt | ./mhsendmail --smtp-addr="0.0.0.0:1025" test@mailhog.local

delete:
	kubectl delete deployment mailhog ;\
	kubectl delete service mailhog ;\
	kubectl delete ingress mailhog ;\
	kubectl delete pvc mailhog-maildir ;\
	echo done
