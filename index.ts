import * as k8s from "@pulumi/kubernetes";

const jenkins = new k8s.helm.v2.Chart("jenkinsdev", {
  repo: "stable",
  version: "0.26.0",
  chart: "jenkins",
  values: {
    Master: {AdminPassword: "admselasdp2018!in" },
    Persistence: { Enabled: false }
  }
});

console.log("jenkins: ", jenkins);
