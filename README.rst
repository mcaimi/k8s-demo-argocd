K8S QUARKUS APPLICATION DEMO: GitOps with ArgoCD
================================================

This repo holds the deployment manifests templates that are used to deploy the demo application built from this_ repository into a compatible Kubernetes or Openshift cluster.

This demo uses:

- Git as the source of truth for templates
- ArgoCD as the deployment manager.
- Quarkus as the application runtime for the demo app
- PostgreSQL as a backend relational DB
- ServiceMesh for security, observability

Deploy Operators
----------------

Cluster configuration is performed in a GitOps native way. Relevant components are deployed as part of the application itself:

- The Openshift GitOps Operator and ArgoCD Application Controller
- The Openshift Pipelines Operator
- The Openshift Service Mesh Operator and Control Plane instance

.. code:: bash

  $ oc apply -k config/ocp-gitops/operator

Once ArgoCD is up & running, let's  install the remaining dependencies

.. code:: bash

  $ oc apply -k config/ocp-pipelines/argocd
  $ oc apply -k config/ocp-servicemesh/argocd

At some point, the status of every application will converge to an healthy and synced state.

Deploy Tekton Pipelines and Build the Application
-------------------------------------------------

The application lifecycle is managed through ArgoCD:

- There is one folder that contains Tekton Build Pipelines and Pipeline Triggers used to build the runnable container image
- Another folder contains the Quarkus Application deployment manifests
- Servicemesh configuration is configured as a standalone ArgoCD Application as well as the backend DB.

First step, deploy the CI Pipelines and frontend deployment manifests:

.. code:: bash

  $ oc apply -k application/quarkus-notes/

At this point, the Backend Database deployment Application and Servicemesh Configuration Application can be created:

.. code:: bash

  $ oc apply -k application/postgres
  $ oc apply -k application/servicemesh

Lastly, the Quarkus App must be built. Either run the pipeline or configure a Git webhook that calls into the EventListener in tekton.

.. _this: https://github.com/mcaimi/quarkus-notes.git
