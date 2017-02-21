var Request = require('loopback-supertest');
var chai    = require('chai');

chai.use(require('chai-subset'));
Request.USERS = 'Accounts';
