FROM quay.io/operator-framework/ansible-operator:v1.22.1

###################################################################### 

ARG ARCH=arm64

USER 0
# USER root

# Download Helm and Install Helm
RUN curl https://get.helm.sh/helm-v3.9.1-linux-${ARCH}.tar.gz \
      --output /tmp/helm-v3.9.1-linux-${ARCH}.tar.gz && \
      tar -xvzf /tmp/helm-v3.9.1-linux-${ARCH}.tar.gz -C /tmp && \
      mv /tmp/linux-${ARCH}/helm /usr/local/bin/helm && \
      rm -rf /tmp/helm-v3.9.1-linux-${ARCH}.tar.gz /tmp/linux-${ARCH}

# USER 1001
# USER ansible

###################################################################### 

COPY requirements.yml ${HOME}/requirements.yml
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/
