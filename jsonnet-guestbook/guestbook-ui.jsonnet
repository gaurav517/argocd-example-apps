local params = import 'params.libsonnet';

[
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: params.name,
    },
    spec: {
      ports: [
        {
          port: params.servicePort,
          targetPort: params.containerPort,
        },
      ],
      selector: {
        app: params.name,
      },
      type: params.type,
    },
  },
  {
    apiVersion: 'argoproj.io/v1alpha1',
    kind: 'Rollout',
    metadata: {
      name: params.name,
    },
    spec: {
      replicas: params.replicas,
      strategy: {
        canary: {
          steps: [
            { setWeight: 20 },
            { pause: {} },
            { setWeight: 40 },
            { pause: { duration: 10 } },
            { setWeight: 60 },
            { pause: { duration: 10 } },
            { setWeight: 80 },
            { pause: { duration: 10 } },
          ],
        },
      },
      revisionHistoryLimit: 3,
      selector: {
        matchLabels: {
          app: params.name,
        },
      },
      template: {
        metadata: {
          labels: {
            app: params.name,
          },
        },
        spec: {
          containers: [
            {
              image: params.image,
              name: params.name,
              ports: [
                {
                  containerPort: params.containerPort,
                },
              ],
            },
          ],
        },
      },
    },
  },
]
