const express = require('express');
const app = express();
const jwt = require('express-jwt');
const jwtAuthz = require('express-jwt-authz');
const jwksRsa = require('jwks-rsa');
const cors = require('cors');
const { Pool, Client } = require('pg');
require('dotenv').config();

if (!process.env.AUTH0_DOMAIN || !process.env.AUTH0_AUDIENCE) {
  throw 'Make sure you have AUTH0_DOMAIN, and AUTH0_AUDIENCE in your .env file';
}

const corsOptions =  {
  origin: 'https://hermes-delivery-hub.herokuapp.com'
};

app.use(cors(corsOptions));

const checkJwt = jwt({
  // Dynamically provide a signing key based on the [Key ID](https://tools.ietf.org/html/rfc7515#section-4.1.4) header parameter ("kid") and the signing keys provided by the JWKS endpoint.
  secret: jwksRsa.expressJwtSecret({
    cache: true,
    rateLimit: true,
    jwksRequestsPerMinute: 5,
    jwksUri: `https://${process.env.AUTH0_DOMAIN}/.well-known/jwks.json/`
  }),

  // Validate the audience and the issuer.
  audience: process.env.AUTH0_AUDIENCE,
  issuer: `https://${process.env.AUTH0_DOMAIN}/`,
  algorithms: ['RS256']
});

const checkScopes = jwtAuthz(['read:messages']);

app.get('/api/public', function(req, res) {
  res.json({
    message: 'Hello from a public endpoint! You don\'t need to be authenticated to see this.'
  });
});

app.get('/api/private', checkJwt, function(req, res) {
  res.json({
    message: 'Hello from a private endpoint! You need to be authenticated to see this.'
  });
});

app.get('/api/private-scoped', checkJwt, checkScopes, function(req, res) {
  res.json({
    message: 'Hello from a private endpoint! You need to be authenticated and have a scope of read:messages to see this.'
  });
});

app.use(function(err, req, res, next){
  console.log(req.headers)
  console.error(err.stack);
  return res.status(err.status).json({ message: err.message });
});



//Connecting the database to the backend

//Connecting to the database so we can query it, etc.
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'hermes',
  password: 'a',
  port: 5432,
})

//Does the same thing, but mimics how the client would do it...
const client = new Client({
  user: 'postgres',
  host: 'localhost',
  database: 'hermes',
  password: 'a',
  port: 5432,
})

client.connect()
client.query('SELECT * FROM Users;', (err, res) => {
  console.log(err, res)
  client.end()
})


//TODO: Implement an abstraction for the database for non-sql experts to use...


app.listen(process.env.PORT || 5000);
console.log('Listening');
