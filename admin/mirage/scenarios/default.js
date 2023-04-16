export default function(server) {
  server.loadFixtures('apps');
  server.loadFixtures('builds');
  server.loadFixtures('host-apps');
  server.loadFixtures('pubkeys');
}
