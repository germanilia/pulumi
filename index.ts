import * as awsinfra from "@pulumi/aws-infra";
import * as eks from "@pulumi/eks";
import * as helm from "@pulumi/kubernetes/helm";
import * as k8s from "@pulumi/kubernetes";
import * as pulumi from "@pulumi/pulumi";

// Create a VPC for our cluster.
const vpc = new awsinfra.Network("vpc");

// Create the EKS cluster itself, including a "gp2"-backed StorageClass and a deployment of the Kubernetes dashboard.
const cluster = new eks.Cluster("cluster", {
  vpcId: vpc.vpcId,
  subnetIds: vpc.subnetIds,
  instanceType: "t2.medium",
  desiredCapacity: 2,
  minSize: 1,
  maxSize: 2,
  storageClasses: "gp2",
  deployDashboard: true
});

// Export the cluster's kubeconfig.
export const kubeconfig = cluster.kubeconfig;

const myk8s = new k8s.Provider("myk8s", {
  kubeconfig: cluster.kubeconfig.apply(JSON.stringify)
});

/* const wordpress = new k8s.helm.v2.Chart(
  "wpdev",
  {
    repo: "stable",
    version: "5.0.2",
    chart: "wordpress",
    values: {
      wordpressUsername: "admin",
      wordpressPassword: "selasdp2018!",
      mariadb: { enabled: false},
      persistence: { storageClass: "gp2" }
    }
  },
  { providers: { kubernetes: myk8s } }
);

// Export the public IP for Wordpress.
const frontend = wordpress.getResourceProperty(
  "v1/Service",
  "wpdev-wordpress",
  "status"
);
export const frontendIp = frontend.apply(
  status => status.loadBalancer.ingress[0].ip
); */

const jenkins = new k8s.helm.v2.Chart(
    "jenkinsdev",
    {
      repo: "bitnami",
      version: "2.1.1",
      chart: "jenkins",
      values: {
        jenkinsUsername: "admin",
        jenkinsPassword: "selasdp2018!",
        persistence: { storageClass: "gp2" }
      }
    },
    { providers: { kubernetes: myk8s } }
  );

  console.log("jenkins: ", jenkins);

