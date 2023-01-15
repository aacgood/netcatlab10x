#!/bin/bash
echo "Setup Script for Netcat 10X Lab"
echo "-------------------------------"
echo "[*] Checking for Minikube"

if [ $(which minikube) ]; then
    echo "[*] Minikube Found"
else
    echo "[X] Ensure the host is running Minikube"
    exit
fi

echo "[*] Checking for Kubectl"

if [ $(which kubectl) ]; then
    echo "[*] Kubectl Found"
    echo "[-] Enter in the desired FQDN for this lab:"
    read VAR_INGRESS_HOST
    echo "[*] Updating ingress/ingress.yaml"
    sed -i "s|var.ingress_host|$VAR_INGRESS_HOST|g" ./ingress/ingress.yaml
    
    echo "[*] Applying namespace/netcatlab-namespace.yaml"
    kubectl apply -f namespace/netcatlab-namespace.yaml    

    echo "[*] Applying ingress/ingress.yaml"
    kubectl apply -f ingress/ingress.yaml

    echo "[*] Applying secrets/netcatlab-secrets.yaml"
    kubectl apply -f secrets/netcatlab-secrets.yaml

    echo "[*] Building Webterminal Dockerfile"
    cd webterminal
    docker build . -t webterminal
            
    echo "[*] Uploading Webterminal image to Minikube"
    minikube image load webterminal
    cd ..

    echo "[*] Applying Network Policy Files"
    kubectl apply -f networkpolicy/allow-8080-any.yaml
    kubectl apply -f networkpolicy/terminal.yaml
    kubectl apply -f networkpolicy/stage0.yaml
    kubectl apply -f networkpolicy/stage1.yaml
    kubectl apply -f networkpolicy/stage2.yaml
    kubectl apply -f networkpolicy/stage3.yaml
    kubectl apply -f networkpolicy/stage4.yaml
    kubectl apply -f networkpolicy/stage5.yaml
    kubectl apply -f networkpolicy/stage6.yaml
    kubectl apply -f networkpolicy/stage7.yaml
    kubectl apply -f networkpolicy/stage8.yaml
    kubectl apply -f networkpolicy/stage9.yaml

    echo "[*] Standing up Lab"
    kubectl apply -f deployment/terminal-depl.yaml
    kubectl apply -f deployment/stage0-depl.yaml
    kubectl apply -f deployment/stage1-depl.yaml
    kubectl apply -f deployment/stage2-depl.yaml
    kubectl apply -f deployment/stage3-depl.yaml
    kubectl apply -f deployment/stage4-depl.yaml
    kubectl apply -f deployment/stage5-depl.yaml
    kubectl apply -f deployment/stage6-depl.yaml
    kubectl apply -f deployment/stage7-depl.yaml
    kubectl apply -f deployment/stage8-depl.yaml
    kubectl apply -f deployment/stage9-depl.yaml

    echo "[*] Dont forget to update DNS with the following entries"
    echo "[-] terminal.$VAR_INGRESS_HOST"
    echo "[-] stage0.$VAR_INGRESS_HOST"
    echo "[-] stage1.$VAR_INGRESS_HOST"
    echo "[-] stage2.$VAR_INGRESS_HOST"
    echo "[-] stage3.$VAR_INGRESS_HOST"
    echo "[-] stage4.$VAR_INGRESS_HOST"
    echo "[-] stage5.$VAR_INGRESS_HOST"
    echo "[-] stage6.$VAR_INGRESS_HOST"
    echo "[-] stage7.$VAR_INGRESS_HOST"
    echo "[-] stage8.$VAR_INGRESS_HOST"

    echo "Current pods"
    kubectl get pod -n netcatlab

    echo '[*] Script Complete!'


else
    echo "[X] Ensure the host is running Kubernetes"
    exit
fi
