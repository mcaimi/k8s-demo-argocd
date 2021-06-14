K8S QUARKUS APPLICATION DEMO: GitOps with ArgoCD
================================================

This repo holds the deployment manifests templates that are used to deploy the demo application built from this_ repository into a compatible Kubernetes or Openshift cluster.

This demo uses:

- Git as the source of truth for templates
- ArgoCD as the deployment manager.

Usage
-----

Follow instructions from this_ repository to setup a Kubernetes or Openshift cluster with all required components:

- Jenkins and plugins
- Sonatype Nexus
- SonarQube 8

Set up pipelines in the CI project to run and produce a binary runnable image:

- Agents are built with buildconfigs on Openshift
- Code artifacts are built with jenkins
- Image signing is optional
- Use of Nexus as a docker registry is mandatory

Once all pipelines finish their job, ArgoCD can be instructed to deploy the application:

.. code:: bash

  $ oc new-project quarkus-notes
  $ oc apply -k argo/

Instructions on how to deploy ArgoCD on Openshift can be found in the ocp4-argocd_ repository

TODO
====

- Streamline the demo workflow
- Fix all inevitable bugs
- Write better documentation...

.. _this: https://github.com/mcaimi/k8s-demo-app.git
.. _ocp4-argocd: https://github.com/mcaimi/ocp4-argocd.git
