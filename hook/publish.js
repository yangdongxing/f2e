<<<<<<< Updated upstream
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
=======
/**
 * git hook 自动推送
 */
var http = require('http');
var createHandler = require('github-webhook-handler');
var handler = createHandler({ path: '/fetch', secret: 'Gfk74nSvgqpCF6V1h7wi' });
// var handler = createHandler({ path: '/fetch' });
// 上面的 secret 保持和 GitHub 后台设置的一致

function run_cmd(cmd, args, callback) {
  var spawn = require('child_process').spawn;
  var child = spawn(cmd, args);
  var resp = "";

  child.stdout.on('data', function(buffer) { resp += buffer.toString(); });
  child.stdout.on('end', function() { callback (resp) });
}

http.createServer(function (req, res) {
  handler(req, res, function (err) {
    res.statusCode = 404
    res.end('no such location')
  })
}).listen(6030);

handler.on('error', function (err) {
  console.error('Error:', err.message)
})

handler.on('push', function (event) {
  console.log('Received a push event for %s to %s',
    event.payload.repository.name,
    event.payload.ref);
  run_cmd('sh', ['./bin/deploy.sh'], function(text){ console.log(text) });
})

/*
handler.on('issues', function (event) {
  console.log('Received an issue event for % action=%s: #%d %s',
    event.payload.repository.name,
    event.payload.action,
    event.payload.issue.number,
    event.payload.issue.title)
})
*/
<<<<<<< Updated upstream
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
