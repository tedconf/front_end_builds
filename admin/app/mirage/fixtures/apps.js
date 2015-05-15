export default [
  {
    id: 1,
    name: 'blog',
    client: 'Web',
    location: '/engineering/blog',
    require_manual_activation: true,
    build_ids: [1, 2, 3, 4],
    live_build_id: 2
  },
  {
    id: 2,
    name: 'finance app',
    client: 'Web',
    location: '/finance/reports',
    require_manual_activation: false,
    build_ids: []
  },
  {
    id: 3,
    name: 'crm',
    client: 'Web',
    location: '/people',
    require_manual_activation: false,
    build_ids: []
  },
];
