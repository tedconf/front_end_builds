export default [
  {
    id: 1,
    name: 'blog',
    location: '/engineering/blog',
    require_manual_activation: true,
    build_ids: [1, 2, 3, 4],
    live_build_id: 2
  },
  {
    id: 2,
    name: 'finance app',
    location: '/finance/reports',
    require_manual_activation: true,
    build_ids: []
  },
  {
    id: 3,
    name: 'crm',
    location: '/people',
    require_manual_activation: false,
    build_ids: []
  },
  {
    id: 4,
    name: 'test',
    location: '/test',
    require_manual_activation: false,
    build_ids: []
  },
];
