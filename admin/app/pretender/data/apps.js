export default [
  {
    id: 1,
    name: 'blog',
    api_key: 'f6db3e76-8f6a-4591-9231-28c271aca36b',
    location: '/engineering/blog',
    require_manual_activation: true,
    build_ids: [1, 2, 3, 4],
    live_build_id: 2
  },
  {
    id: 2,
    name: 'accounting-reports',
    location: '/finance/reports',
    api_key: 'e241cdf3-5b46-49e6-a962-c857a557d470',
    require_manual_activation: false,
    build_ids: []
  },
  {
    id: 3,
    name: 'crm',
    location: '/people',
    api_key: 'eca7ad25-5de4-467d-8a28-6ca2d2f48c55',
    require_manual_activation: false,
    build_ids: []
  },
];
