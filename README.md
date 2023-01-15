# README

This lab was built using an Ubuntu Desktop host with Minikube installed.  

A quick setup.sh script has been provided that will:

- Ask what domain you want to configure and update the ingress file accordingly
- Create a `netcatlab` namespace
- Apply all the assocaited `Network Policy` files
- Apply the `secrets` file (Customise as you wish)
- Build the `webterminal` Docker image and upload it into minikube
    - Image is based off python/alpine
    - Contains GoTTY so the terminal can be accessed from a browser
    - Simple Flask webserver
    - Startup script
    - Basic lockdown (ie: not running as root)
- Apply the `deployment` files for each stage


