var webhooker = require('gitlab-webhooker');

webhooker.init({
  // token: 'Gfk74nSvgqpCF6V1h7wi',
  token: undefined,
  port: 6030,
  branches: ['master'],
  events: ['push', 'merge_request'],
  command: 'sh ./bin/deploy.sh'
  // exit: true
});
