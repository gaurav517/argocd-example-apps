{
  containerPort: 80,
  image: "argoproj/rollouts-demo:yellow",
  name: "jsonnet-guestbook-ui",
  replicas: 10,
  servicePort: 80,
  type: "ClusterIP",
}
