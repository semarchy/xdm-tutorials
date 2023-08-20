This is an example of a kubernetes deployment of Semarchy that is pointing to an external-to-the-k8s-cluster postgresql database.

You should supply the secrets in the secrets.yaml file for DB URL and credentials.

nginx-ingress.yaml is for a deployment where your TLS certificates are integrated with vault. Hopefully you can translate this into your specific implementation's use-case if this doesn't work for you.
