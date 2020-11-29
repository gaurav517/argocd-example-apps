{
  containerPort: 8080,
  image: "argoproj/rollouts-demo:blue",
  name: "jsonnet-guestbook-ui",
  replicas: 10,
  servicePort: 8080,
  type: "ClusterIP",
}
