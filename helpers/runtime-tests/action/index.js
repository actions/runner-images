const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');

assert.equal(process.platform, 'linux');
assert.equal(os.userInfo().username, 'packer');
assert.notEqual(process.getuid(), 0);
fs.appendFileSync(process.env.GITHUB_OUTPUT, 'result=image-smoke-ok\n');
console.log('JavaScript action ran successfully inside the built image.');
